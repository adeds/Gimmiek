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
    
    var userProvider: UserDataProviderProtocol!
    var accountRepository: AccountRepositoryProtocol!
    var accountInteractor: AccountInteractorProtocol!
    var accountViewModel: AccountViewModel!
    
    var router: RouterProtocol!
    
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
        precondition(userProvider != nil)
        precondition(accountRepository != nil)
        precondition(accountInteractor != nil)
        precondition(accountViewModel != nil)
        precondition(router != nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView(router: router).environmentObject(viewModel)
        }
    }
}

extension GimmiekApp {
    func injectProperties(
        _ networker: NetworkerProtocol,
        _ repository: GameRepositoryProtocol,
        _ interactor: GameInteractorProtocol,
        _ viewModel: GameListViewModel,
        
        _ userProvider: UserDataProviderProtocol,
        _ accountRepository: AccountRepositoryProtocol,
        _ accountInteractor: AccountInteractorProtocol,
        _ accountViewModel: AccountViewModel,
        
        _ router: RouterProtocol
    ) {
        self.networker = networker
        self.repository = repository
        self.interactor = interactor
        self.viewModel = viewModel
        
        self.userProvider = userProvider
        self.accountRepository = accountRepository
        self.accountInteractor = accountInteractor
        self.accountViewModel = accountViewModel
        
        self.router = router
    }
}
