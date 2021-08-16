//
//  GameUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

class GameUseCase : ObservableObject {
    
    @Published var games = [GameUiModel]()
    
    @Published var isLoading = false
    var startIndex: Int { games.startIndex }
    var endIndex: Int { games.endIndex }
    
    var page = 1
    
    let gameListUrl = Constant.rawgBaseUrl
        + Constant.Path.games
        + Constant.QueryName.key + Constant.rawrgApiKey
    
    init() {
        let url = gameListUrl + Constant.QueryName.page + String(page)
        fetchGameList(url: url)
    }
    
    func searchGame(keyword : String){
        let url = gameListUrl + Constant.QueryName.search + keyword
        print(url)
        fetchGameList(url: url, isAppend: false)
    }
    
    func fetchGameList(url : String, isAppend : Bool = true) {
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        if let url = URL(string: encodedUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
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
                    if (!isAppend){
                        self.games.removeAll()
                    }
                    if !newGames.isEmpty{
                        self.games.append(contentsOf: newGames)
                    }
                    
                    self.isLoading = false
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = true
            }
            task.resume()
        }else{
            print("url null")
        }
    }
    
    
    func parseJSON(_ data : Data) -> [GameUiModel]? {
        let decoder = JSONDecoder()
        do {
            let gameList = try decoder.decode(Game.self, from: data).results
            return gameList.map({ (game) -> GameUiModel in
                let name = game.name ?? "not found"
                let released = game.released ?? "not found"
                let backgroundImage = game.backgroundImage
                return GameUiModel(name: name, released: released, backgroundImage: backgroundImage)
            })
            
        } catch {
            print(error)
            return nil
        }
    }
}
