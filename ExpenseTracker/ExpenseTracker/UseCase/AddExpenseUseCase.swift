//
//  AddExpenseUseCase.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import Foundation

class AddExpenseUseCase{
    private let repository: AddExpenseRepository
    
    init(repository: AddExpenseRepository) {
        self.repository = repository
    }
    
    func addExpense(amount: Double, category: String, date: Date, note: String?,completion:@escaping(Bool)->Void){
        repository.save(amount: amount, category: category, date: date, note: note){result in
            completion(result)
        }
    }
    func updateExpense(expenseId:UUID,amount: Double, category: String, date: Date, note: String?,completion:@escaping(Bool)->Void){
        repository.update(expenseId:expenseId,amount: amount, category: category, date: date, note: note){result in
            completion(result)
        }
    }
}
