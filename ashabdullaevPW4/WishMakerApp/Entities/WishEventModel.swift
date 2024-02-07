//
//  WishEventModel.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 07.02.2024.
//

import CoreData

public class WishEventModel : NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var descriptionText: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
}
