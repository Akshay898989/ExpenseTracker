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
}

class DashboardExpenseRepository:ExpenseRepository{
    
    func fetchAllExpenses() -> [Expense] {
        return Expense.all()
    }
    
}
