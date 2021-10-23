//
//  GimmiekApp.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI
import Cleanse

@main
class GimmiekApp: App {
    var networker : NetworkerProtocol!
    var repository: GameRepositoryProtocol!
    var interactor: GameInteractorProtocol!
    var viewModel : GameListViewModel!
    
    required init() {
        do {
            let propertyInjector = try ComponentFactory.of(AppComponent.self).build(())
            propertyInjector.injectProperties(into: self)
        } catch {
            print("failed inject \(error)")
        }
        
        precondition(networker != nil)
        precondition(repository != nil)
        precondition(interactor != nil)
        precondition(viewModel != nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}

extension GimmiekApp {
    func injectProperties(
        _ networker: NetworkerProtocol,
        _ repository: GameRepositoryProtocol,
        _ interactor: GameInteractorProtocol,
        _ viewModel: GameListViewModel ) {
            self.networker = networker
            self.repository = repository
            self.interactor = interactor
            self.viewModel = viewModel
        }
}
