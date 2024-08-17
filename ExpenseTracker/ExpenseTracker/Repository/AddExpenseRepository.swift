//
//  AddExpenseRepository.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import Foundation

protocol AddExpenseRepository{
    func save(amount: Double, category: String, date: Date, note: String?,completion:@escaping(Bool)->Void)
}

class AddExpenseRepositoryImpl:AddExpenseRepository{
    func save(amount: Double, category: String, date: Date, note: String?,completion:@escaping(Bool)->Void) {
        let expense = Expense(context: Expense.viewContext)
        expense.id = UUID()
        expense.createdAt = Date()
        expense.amount = amount
        expense.category = category
        expense.date = date
        expense.note = note
        expense.save { result in
            switch result{
            case .success(_):
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    
}
