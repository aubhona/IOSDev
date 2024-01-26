//
//  CSViewController.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import UIKit

protocol DisplayLogic: AnyObject {
    func displayStart()
}

class CSViewController: UIViewController {
    var interactor: BusinessLogic
    var router: RoutingLogic
    
    init(interactor: BusinessLogic, router: RoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadStart()
    }


}

extension CSViewController: DisplayLogic {
    func displayStart() {
        print("Hello")
        router.openStart()
    }
    
    
}
