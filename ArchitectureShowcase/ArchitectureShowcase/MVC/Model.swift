//
//  Model.swift
//  ArchitectureShowcase
//
//  Created by Aubkhon Abdullaev on 26.01.2024.
//

enum MVCModel {
    struct Login {
        var username: String
        var email: String
        
        var name: String
        var lastName: String
        var middleName: String
        
        var fio: String {
            return lastName + name + middleName
        }
    }
}
