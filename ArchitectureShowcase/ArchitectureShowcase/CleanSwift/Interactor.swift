//
//  Interactor.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import Foundation

protocol BusinessLogic {
    func loadStart()
}

final class Interactor: BusinessLogic {
    var presenter: PresentationLogic
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    func loadStart() {
        presenter.presentStart()
    }
}
