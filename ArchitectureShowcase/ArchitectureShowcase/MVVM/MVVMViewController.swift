//
//  MVVMViewController.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import UIKit

final class MVVMViewController: ViewController {
    private var viewModel : ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewController = self
        //viewModel.login(model: MVVMModel.Login(username: <#T##String#>, email: <#T##String#>, name: <#T##String#>, lastName: <#T##String#>, middleName: <#T##String#>))
       
    }
    
    func showUsername(_ username: String) {
        // show
    }
}

