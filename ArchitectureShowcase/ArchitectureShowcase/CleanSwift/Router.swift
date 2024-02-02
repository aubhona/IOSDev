//
//  Router.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

import UIKit

protocol RoutingLogic {
    func openStart()
}

class Router : RoutingLogic {
    weak var vc: DisplayLogic?
    
    func openStart() {
       
    }
     
}
