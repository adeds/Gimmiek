//
//  AccountRepository.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Combine
import Cleanse

protocol AccountRepositoryProtocol {
    func getName() -> AnyPublisher<String, Error>
    func setName(name:String) -> AnyPublisher<String, Error>
}

class AccountRepository : AccountRepositoryProtocol {
    
    let userDataProvider: UserDataProviderProtocol
    
    init(userDataProvider: UserDataProviderProtocol) {
        self.userDataProvider = userDataProvider
    }
    
    func getName() -> AnyPublisher<String, Error> {
        return userDataProvider.getName()
    }
    
    func setName(name:String) -> AnyPublisher<String, Error> {
        return userDataProvider.setName(name: name)
    }
    
}

extension AccountRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(AccountRepositoryProtocol.self).to(factory: AccountRepository.init)
        }
    }
}

