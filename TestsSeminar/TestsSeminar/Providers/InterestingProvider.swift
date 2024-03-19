//
//  InterestingProvider.swift
//  TestsSeminar
//
//  Created by Aubkhon Abdullaev on 01.03.2024.
//

import Foundation

final class InterestingProvider: Provider {
    
    public func user() -> User {
        User(name: "Кто-то", lastname: "Интересный", age: 101, link: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyDAgd2sCDa9Nwok49OknawtraDbLfLq_Uv1isLfy3ANqNjz0WAHUUmOPlpl_bfFmAeV4&usqp=CAU")
    }
}
