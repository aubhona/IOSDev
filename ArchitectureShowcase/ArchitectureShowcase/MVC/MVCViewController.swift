//
//  MVCViewController.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import UIKit

final class MVCViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = MVCView()
        
        view.addSubview(myView)
    }
}
