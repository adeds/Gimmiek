//
//  GimmiekApp.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI
import Cleanse

@main
struct GimmiekApp: App {
    var networker : NetworkerProtocol!
    var interactor: GameInteractorProtocol!
    var repository: GameRepositoryProtocol!
    var viewModel : GameListViewModel!
    
    required init() {
        let propertyInjector = try? ComponentFactory.of(AppComponent.self).build(())
        propertyInjector?.injectProperties(into: self)
        precondition(networker != nil)
        precondition(interactor != nil)
        precondition(repository != nil)
        precondition(viewModel != nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView.init(viewModel: viewModel)
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
