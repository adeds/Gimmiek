//
//  GameUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation
import Alamofire

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
        // todo : move to repository
        
        AF.request(url).responseDecodable(of: Game.self) { response in
            if response.error != nil {
                print(response.error ?? "error")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } else {
                if let game = response.value {
                    self.isLastPage = game.next == nil
                    let gameUiModels =  game.results.map { itemGame in
                        GameUiModel(
                            gameId: itemGame.id,
                            name: itemGame.name ?? " - ",
                            released: itemGame.released ?? " - ",
                            updated: itemGame.updated ?? " - ",
                            backgroundImage: itemGame.backgroundImage,
                            rating: itemGame.rating ?? 0.0,
                            ratingTop: itemGame.ratingTop ?? 0,
                            platforms: self.getPlatform(itemGame.platforms),
                            genres: self.getGenresAndTags(itemGame.genres),
                            screenshots: self.getScreenshots(itemGame.shortScreenshots),
                            tags: self.getGenresAndTags(itemGame.tags))
                    }
                    DispatchQueue.main.async {
                        if !isAppend {
                            self.games.removeAll()
                        }
                        if !gameUiModels.isEmpty {
                            self.games.append(contentsOf: gameUiModels)
                        }
                        self.isLoading = false
                    }
                }
            }
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
