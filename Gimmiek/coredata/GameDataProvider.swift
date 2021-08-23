//
//  Persistence.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 23/08/21.
//

import CoreData

class GameDataProvider {
    static let shared = GameDataProvider()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: Constant.CoreData.gameDataName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    private struct GameContract {
        static let backgroundImage = "backgroundImage"
        static let gameId = "gameId"
        static let released = "gameReleased"
        static let updated = "gameUpdated"
        static let genres = "genres"
        static let name = "name"
        static let platforms = "platforms"
        static let  rating = "rating"
        static let  ratingTop = "ratingTop"
        static let screenshots = "screenshots"
        static let tags = "tags"
    }
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = container.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func changeFavorites(_ gameUiModel: GameUiModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: Constant.CoreData.gameDataModel, in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(gameUiModel.backgroundImage, forKeyPath: GameContract.backgroundImage)
                game.setValue(gameUiModel.gameId, forKeyPath: GameContract.gameId)
                game.setValue(gameUiModel.released, forKeyPath: GameContract.released)
                game.setValue(gameUiModel.updated, forKeyPath: GameContract.updated)
                game.setValue(listToJsonString(list:gameUiModel.genres), forKeyPath: GameContract.genres)
                game.setValue(gameUiModel.name, forKeyPath: GameContract.name)
                game.setValue(listToJsonString(list:gameUiModel.platforms), forKeyPath: GameContract.platforms)
                game.setValue(gameUiModel.rating, forKeyPath: GameContract.rating)
                game.setValue(gameUiModel.ratingTop, forKeyPath: GameContract.ratingTop)
                game.setValue(listToJsonString(list:gameUiModel.screenshots), forKeyPath: GameContract.screenshots)
                game.setValue(listToJsonString(list:gameUiModel.tags), forKeyPath: GameContract.tags)
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        }
    }
    
    func listToJsonString(list : [String]) -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(list)
            let json = String(data: jsonData, encoding: String.Encoding.utf16) ?? ""
            return json
        }catch{
            print(error)
            return ""
        }
    }
    
    func checkFavorites(_ gameUiModel: GameUiModel, completion: @escaping(_ isFavorite: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constant.CoreData.gameDataModel)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "gameId == \(gameUiModel.gameId ?? 0)")
            
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    if let name = result.value(forKey: "name") as? String{
                        completion(!name.isEmpty)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    }
}
