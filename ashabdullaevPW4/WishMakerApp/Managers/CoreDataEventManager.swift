//
//  CoreDataEventManager.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 07.02.2024.
//

import UIKit
import CoreData

public final class CoreDataEventManager : NSObject {
    public static let shared = CoreDataEventManager()
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private func increaseAllInd(id: Int) {
        fetchWish().forEach({ if ($0.id > id) { $0.id -= 1} })
        
        appDelegate.saveContext()
    }
    
    public func createWish(id: Int, title: String, description: String, startDate: Date, endDate: Date) -> WishEventModel? {
        guard let wishEntityDescription = NSEntityDescription.entity(forEntityName: "WishEventModel", in: context) else { return nil }
        let wish = WishEventModel(entity: wishEntityDescription, insertInto: context)
        wish.id = id
        wish.title = title
        wish.descriptionText = description
        wish.startDate = startDate
        wish.endDate = endDate
        
        appDelegate.saveContext()
        
        return wish
    }
    
    public func fetchWish(id: Int) -> WishEventModel? {
        let fetchRequest = NSFetchRequest<WishEventModel>(entityName: "WishEventModel")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let wishes = try context.fetch(fetchRequest)
            return wishes.first
        } catch {
            print("Error fetching wish: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func updateWish(id: Int, newTitle: String, newDescription: String, newStartDate: Date, newEndDate: Date) {
        guard let wish = fetchWish(id: id) else { return }
        wish.title = newTitle
        wish.descriptionText = newDescription
        wish.startDate = newStartDate
        wish.endDate = newEndDate
        
        appDelegate.saveContext()
    }
    
    public func deleteWish(id: Int) {
        guard let wish = fetchWish(id: id) else { return }
        context.delete(wish)
        
        appDelegate.saveContext()
        increaseAllInd(id: id)
    }
    
    public func fetchWish() -> [WishEventModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishEventModel")
        
        return (try? context.fetch(fetchRequest) as? [WishEventModel]) ?? []
    }
}
