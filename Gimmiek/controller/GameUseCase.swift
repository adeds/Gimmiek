//
//  GameUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

class GameUseCase: ObservableObject {
    
    @Published var games = [GameUiModel]()
    
    @Published var isLoading = false
    
    private var isLastPage = false
    
    private var page = 1
    
    private var currentUrl = ""
    
    let gameListUrl = Constant.rawgBaseUrl
    + Constant.Path.games
    + Constant.QueryName.key + Constant.rawrgApiKey
    
    init() {
        searchGame(keyword: "")
    }
    
    func searchGame(keyword: String) {
        page = 1
        currentUrl = gameListUrl + Constant.QueryName.search + keyword
        fetchGameList(url: currentUrl + Constant.QueryName.page + String(page), isAppend: false)
    }
    
    func loadMore(game: GameUiModel) {
        if isLoading || isLastPage {
            return
        }
        if games.count < 9 {
            return
        }
        
        if games[games.count-5].uuid == game.uuid {
            page += 1
            let url = currentUrl + Constant.QueryName.page + String(page)
            fetchGameList(url: url)
        }
    }
    
    func fetchGameList(url: String, isAppend: Bool = true) {
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        print(url)
        if let url = URL(string: encodedUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    print(error ?? "error fetch data game")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                guard let safeData = data else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                guard let newGames = self.parseJSON(safeData) else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if !isAppend {
                        self.games.removeAll()
                    }
                    if !newGames.isEmpty {
                        self.games.append(contentsOf: newGames)
                    }
                    
                    self.isLoading = false
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = true
            }
            task.resume()
        } else {
            print("url null")
        }
    }
    func parseJSON(_ data: Data) -> [GameUiModel]? {
        let decoder = JSONDecoder()
        do {
            let gameResponse = try decoder.decode(Game.self, from: data)
            self.isLastPage = gameResponse.next == nil
            return gameResponse.results.map({(game) -> GameUiModel in
                let gameId = game.id
                let name = game.name ?? " - "
                let released = game.released ?? " - "
                let updated = game.released ?? " - "
                let backgroundImage = game.backgroundImage
                let rating = game.rating ?? 0.0
                let ratingTop = game.ratingTop ?? 0
                let platforms = getPlatform(game.platforms)
                let genres = getGenresAndTags(game.genres)
                let screenshots = getScreenshots(game.shortScreenshots)
                let tags = getGenresAndTags(game.tags)
                return GameUiModel(gameId: gameId, name: name,
                                   released: released, updated: updated,
                                   backgroundImage: backgroundImage,
                                   rating: rating, ratingTop: ratingTop,
                                   platforms: platforms, genres: genres, screenshots: screenshots, tags: tags)
            })
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func getPlatform(_ platforms: [PlatformElement]?) -> [String] {
        guard let platforms = platforms else {
            return [String]()
        }
        return platforms.compactMap { $0.platform?.name }
    }
    
    func getGenresAndTags(_ genres: [Genre]?) -> [String] {
        guard let genres = genres else {
            return [String]()
        }
        return genres.compactMap { $0.name }
    }
    
    func getScreenshots(_ screenshots: [ShortScreenshot]?) -> [String] {
        guard let screenshots = screenshots else {
            return [String]()
        }
        return screenshots.compactMap { $0.image }
    }
}
