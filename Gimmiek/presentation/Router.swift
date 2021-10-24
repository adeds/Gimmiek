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
}

class Router: RouterProtocol {
    let accountViewModel: AccountViewModel
    init(accountViewModel:AccountViewModel) {
        self.accountViewModel = accountViewModel
    }
    func toAccountDetail() -> AccountDetailView {
        return AccountDetailView(viewModel: accountViewModel)
    }
}

extension Router {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(RouterProtocol.self).to(factory: Router.init)
        }
    }
}
