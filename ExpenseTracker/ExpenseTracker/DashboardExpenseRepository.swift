//
//  DashboardExpenseRepository.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation
// 1. Data Layer
protocol ExpenseRepository{
    func fetchAllExpenses() -> [Expense]
    func addExpense(amount: Double, category: String, date: Date, note: String?)
}

class DashboardExpenseRepository:ExpenseRepository{
    
    func fetchAllExpenses() -> [Expense] {
        return Expense.all()
    }
    
    func addExpense(amount: Double, category: String, date: Date, note: String?) {
        let expense = Expense(context: Expense.viewContext)
        expense.id = UUID()
        expense.createdAt = Date()
        expense.amount = amount
        expense.category = category
        expense.date = date
        expense.note = note
        expense.save()
    }
    
}
