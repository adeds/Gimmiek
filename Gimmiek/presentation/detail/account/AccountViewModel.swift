//
//  AccountViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Combine
import Cleanse

class AccountViewModel: ObservableObject {
    
    @Published var name: String = ""
    
    private var interactor: AccountInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: AccountInteractorProtocol) {
        self.interactor = interactor
        getName()
    }
    
    func getName(){
        interactor.getName()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.name = result
            }.store(in: &cancellables)
    }
    
    func setName(name:String){
        interactor.setName(name: name)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.name = result
            }.store(in: &cancellables)
    }
}


extension AccountViewModel {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(AccountViewModel.self).to(factory: AccountViewModel.init)
        }
    }
}
