//
//  Assmbly.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import UIKit

enum Assembly {
    static func build() -> UIViewController {
        let presenter = Presenter()
        let router = Router()
        let interactor = Interactor(presenter: presenter)
        let vc = CSViewController(interactor: interactor, router: router)
        
        presenter.vc = vc
        router.vc = vc
        
        return vc
    }
}
