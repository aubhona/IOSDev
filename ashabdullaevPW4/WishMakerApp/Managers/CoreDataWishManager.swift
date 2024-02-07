//
//  CoreDataManager.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 10.11.2023.
//

import UIKit
import CoreData

public final class CoreDataWishManager : NSObject {
    public static let shared = CoreDataWishManager()
    
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
    
    public func createWish(id: Int, wishText: String) {
        guard let wishEntityDescription = NSEntityDescription.entity(forEntityName: "Wish", in: context) else { return }
        let wish = Wish(entity: wishEntityDescription, insertInto: context)
        wish.id = id
        wish.text = wishText
        
        appDelegate.saveContext()
    }
    
    public func fetchWish(id: Int) -> Wish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        guard let wishes = try? context.fetch(fetchRequest) as? [Wish] else { return nil }
        
        return wishes.first(where: {$0.id == id})
    }
    
    public func updateWish (id: Int, newWishText: String) {
        guard let wish = fetchWish(id: id) else { return }
        wish.text = newWishText
        
        appDelegate.saveContext()
    }
    
    public func deleteWish(id: Int) {
        guard let wish = fetchWish(id: id) else { return }
        context.delete(wish)
        
        appDelegate.saveContext()
        increaseAllInd(id: id)
    }
    
    public func fetchWish() -> [Wish] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        return (try? context.fetch(fetchRequest) as? [Wish]) ?? []
    }

}
