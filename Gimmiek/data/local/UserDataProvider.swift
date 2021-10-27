//
//  UserDataProvider.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Combine
import Cleanse

protocol UserDataProviderProtocol {
    func getName() -> AnyPublisher<String, Error>
    func setName(name:String) -> AnyPublisher<String, Error>
}

class UserDataProvider : UserDataProviderProtocol {
    func getName() -> AnyPublisher<String, Error> {
        let name = UserDefaults.standard.object(forKey: Constant.UserDefault.name) as? String ?? "Adetya Dyas Saputra"
        return Just(name).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func setName(name:String) -> AnyPublisher<String, Error> {
        UserDefaults.standard.set(name, forKey: Constant.UserDefault.name)
        return getName()
    }
}

extension UserDataProvider {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(UserDataProviderProtocol.self).to {
                UserDataProvider.init()
            }
        }
    }
}
