//
//  Presenter.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

protocol PresentationLogic {
    func presentStart()
}


final class Presenter: PresentationLogic {
    weak var vc: DisplayLogic?
    
    func presentStart() {
        vc?.displayStart()
    }
}
