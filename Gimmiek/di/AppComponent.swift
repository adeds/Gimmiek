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
        binder.include(module: Networker.Module.self)
        binder.include(module: GameRepository.Module.self)
        binder.include(module: GameInteractor.Module.self)
        binder.include(module: GameListViewModel.Module.self)
    }

    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<GimmiekApp>>) -> BindingReceipt<PropertyInjector<GimmiekApp>> {
        bind.propertyInjector { (bind) -> BindingReceipt<PropertyInjector<GimmiekApp>> in
            return bind.to(injector: GimmiekApp.injectProperties)
        }
    }
}
