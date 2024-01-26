//
//  ViewModel.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import Foundation

final class ViewModel {
    weak var viewController: MVVMViewController?
    
    init(viewController: MVVMViewController? = nil) {
        self.viewController = viewController
    }
    
    func login(model: MVVMModel.Login) {
        print(model.username)
        
        viewController?.showUsername(model.username)
    }
}
