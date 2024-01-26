//
//  AppDelegate.swift
//  ashabdullaevPW2
//
//  Created by Aubkhon Abdullaev on 03.10.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var persistentContainer: NSPersistentContainer = {
        let model = createManagedObjectModel()
        let container = NSPersistentContainer(name: "MyContainer", managedObjectModel: model)
        container.loadPersistentStores{description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url -", description.url?.absoluteString ?? String())
            }
        }
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if !context.hasChanges {
            return
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createManagedObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let wishEntity = NSEntityDescription()
        wishEntity.name = "Wish"
        wishEntity.managedObjectClassName = NSStringFromClass(Wish.self)

        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer64AttributeType
        idAttribute.isOptional = false

        let textAttribute = NSAttributeDescription()
        textAttribute.name = "text"
        textAttribute.attributeType = .stringAttributeType
        textAttribute.isOptional = false

        wishEntity.properties = [idAttribute, textAttribute]
        
        model.entities = [wishEntity]

        return model
    }
}

