//
//  RouterViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Cleanse

protocol RouterProtocol {
    func toAccountDetail() -> AccountDetailView
    func toGameDetail(game: GameUiModel) -> GameDetailView
    func toGameFavorites() -> GameFavoritesView
}

class Router: RouterProtocol {
    let accountViewModel: AccountViewModel
    let gameDetailViewModel: GameDetailViewModel
    let gameFavoriteViewModel: GameFavoritesViewModel
    
    init(
        accountViewModel:AccountViewModel,
        gameDetailViewModel: GameDetailViewModel,
        gameFavoriteViewModel: GameFavoritesViewModel) {
        self.accountViewModel = accountViewModel
        self.gameDetailViewModel = gameDetailViewModel
        self.gameFavoriteViewModel = gameFavoriteViewModel
    }
    func toAccountDetail() -> AccountDetailView {
        return AccountDetailView(viewModel: accountViewModel, router: self)
    }
    
    func toGameDetail(game: GameUiModel) -> GameDetailView {
        return GameDetailView.init(game: game, viewModel: gameDetailViewModel)
    }
    
    func toGameFavorites() -> GameFavoritesView {
        return GameFavoritesView(router: self, viewModel: gameFavoriteViewModel)
    }
}

extension Router {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(RouterProtocol.self).to(factory: Router.init)
        }
    }
}
