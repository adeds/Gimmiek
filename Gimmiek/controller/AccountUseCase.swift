//
//  AccountUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/08/21.
//

import Foundation

class AccountUseCase: ObservableObject {
    
    @Published var name: String {
            didSet {
                UserDefaults.standard.set(name, forKey: Constant.UserDefault.name)
            }
        }
        
        init() {
            self.name = UserDefaults.standard.object(forKey: Constant.UserDefault.name) as? String ?? "Adetya Dyas Saputra"
        }
}
