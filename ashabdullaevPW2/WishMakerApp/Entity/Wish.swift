//
//  Wish.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 10.11.2023.
//

import CoreData

public class Wish: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var text: String
    
}
