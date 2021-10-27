//
//  AccountInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Combine
import Cleanse

protocol AccountInteractorProtocol {
    func getName() -> AnyPublisher<String, Error>
    func setName(name:String) -> AnyPublisher<String, Error>
}

class AccountInteractor : AccountInteractorProtocol {
    let accountRepository: AccountRepositoryProtocol
    
    init(accountRepository: AccountRepositoryProtocol) {
        self.accountRepository = accountRepository
    }
    func getName() -> AnyPublisher<String, Error> {
        return accountRepository.getName()
    }
    
    func setName(name:String) -> AnyPublisher<String, Error> {
        return accountRepository.setName(name: name)
    }
}

extension AccountInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(AccountInteractorProtocol.self).to(factory: AccountInteractor.init)
        }
    }
}
