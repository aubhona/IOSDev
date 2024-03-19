//
//  User.swift
//  TestsSeminar
//
//  Created by Aubkhon Abdullaev on 01.03.2024.
//

import Foundation

struct User {
    var name: String
    var lastname: String
    var age: Int
    var link: URL
    
    init(name: String, lastname: String, age: Int, link: String) {
        self.name = name
        self.lastname = lastname
        self.age = age
        self.link = URL(string: link)!
    }
}
