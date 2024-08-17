//
//  BaseModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation
import CoreData

protocol BaseModel where Self:NSManagedObject{
    func save(completion:@escaping(Result<Void,Error>)->Void)
    static func all<T:NSManagedObject>() -> [T]
    static func byUUID<T: NSManagedObject>(uuid: UUID) -> T?
}

extension BaseModel{
    static var viewContext:NSManagedObjectContext{
        return CoreDataManager.shared.viewContext
    }
    
    func save(completion:@escaping(Result<Void, Error>)->Void){
        do{
            try Self.viewContext.save()
            completion(.success(()))
        }catch{
            Self.viewContext.rollback()
            completion(.failure(error))
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
    
    static func byUUID<T: NSManagedObject>(uuid: UUID) -> T? {
            let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
            fetchRequest.predicate = NSPredicate(format: "id == %@", uuid.uuidString)
            do {
                let results = try viewContext.fetch(fetchRequest)
                return results.first
            } catch {
                return nil
            }
        }
}
