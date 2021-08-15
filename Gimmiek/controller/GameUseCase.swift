//
//  GameUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

class GameUseCase: ObservableObject, RandomAccessCollection {
    typealias Element = GameUiModel
    
    var startIndex: Int { games.startIndex }
    var endIndex: Int { games.endIndex }
    
    subscript(position: Int) -> GameUiModel {
        return games[position]
    }
    
    @Published var games = [GameUiModel]()
    
    @Published var isLoading = false
    
    var page = 1
    
    let gameListUrl = Constant.rawgBaseUrl
        + Constant.Path.games
        + Constant.QueryName.key + Constant.rawrgApiKey
    
    init() {
        fetchGameList()
    }
    
    func fetchGameList() {
        let url = gameListUrl + Constant.QueryName.page + String(page)
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error fetch data game")
                    self.isLoading = false
                    return
                }
                
                guard let safeData = data else {
                    self.isLoading = false
                    return
                }
                
                guard let newGames = self.parseJSON(safeData) else {
                    self.isLoading = false
                    return
                }
                
                DispatchQueue.main.async {
                    self.games.append(contentsOf: newGames)
                    self.isLoading = false
                }
            }
        
            isLoading = true
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
                let name = game.name
                let released = game.released
                return GameUiModel(name: name, released: released)
            })
            
        } catch {
            print(error)
            return nil
        }
    }
}
