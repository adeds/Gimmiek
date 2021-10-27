//
//  AppComponent.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Cleanse

struct AppComponent: Cleanse.RootComponent {
    typealias Root = PropertyInjector<GimmiekApp>

    static func configure(binder: Binder<Singleton>) {
        binder.include(module: GameDataProvider.Module.self)
        
        binder.include(module: Networker.Module.self)
        binder.include(module: GameRepository.Module.self)
        
        binder.include(module: GameInteractor.Module.self)
        binder.include(module: GameListViewModel.Module.self)
        
        binder.include(module: GameDetailInteractor.Module.self)
        binder.include(module: GameDetailViewModel.Module.self)
        
        binder.include(module: UserDataProvider.Module.self)
        binder.include(module: AccountRepository.Module.self)
        binder.include(module: AccountInteractor.Module.self)
        binder.include(module: AccountViewModel.Module.self)
        
        binder.include(module: GameFavoritesInteractor.Module.self)
        binder.include(module: GameFavoritesViewModel.Module.self)
        
        binder.include(module: Router.Module.self)
    }

    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GimmiekApp>>) -> BindingReceipt<PropertyInjector<GimmiekApp>> {
        bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<GimmiekApp>> in
            return bind.to(injector: GimmiekApp.injectProperties)
        }
    }
}
