//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 14/08/24.
//

import Foundation
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    let persitentContainer:NSPersistentContainer
    
    private init() {
        persitentContainer = NSPersistentContainer(name: "ExpenseTracker")
        persitentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }
    
    var viewContext:NSManagedObjectContext{
        return persitentContainer.viewContext
    }
    
}
