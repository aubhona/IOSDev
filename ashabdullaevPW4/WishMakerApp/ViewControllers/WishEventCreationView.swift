//
//  WishEventCreationView.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 07.02.2024.
//

import UIKit
import CoreData

class WishEventCreationView: UIViewController {
    // Define your text fields, date pickers, etc. here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Setup your UI elements and constraints here
    }
    
    // Define a method to save the new WishEvent to CoreData
    func saveNewWishEvent(title: String, description: String, startDate: Date, endDate: Date) {
        // Assuming you have a CoreData stack setup
        // Create a new WishEvent object in the managed object context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        _ = WishEventModel(
            title: "Test",
            description: "Test description",
            startDate: Date(),
            endDate: Date()
        )
//        wishEvent.title = title
//        wishEvent.eventDescription = description
//        wishEvent.startDate = startDate
//        wishEvent.endDate = endDate
//        
        do {
            try managedContext.save()
            // Handle the success, maybe by dismissing this view controller or showing a confirmation message
        } catch let error as NSError {
            // Handle the error, e.g., show an error message
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Add other methods needed for your UI, such as for a save button tap
}
