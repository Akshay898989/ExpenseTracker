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
}
