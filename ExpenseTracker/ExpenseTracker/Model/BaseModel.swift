//
//  BaseModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation
import CoreData

protocol BaseModel where Self:NSManagedObject{
    func save()
    static func all<T:NSManagedObject>() -> [T]
}

extension BaseModel{
    static var viewContext:NSManagedObjectContext{
        return CoreDataManager.shared.viewContext
    }
    
    func save(){
        do{
            try Self.viewContext.save()
        }catch{
            Self.viewContext.rollback()
        }
    }
    
    static func all<T>() -> [T] where T:NSManagedObject{
        let fetchRequest:NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do{
            return try viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
}
