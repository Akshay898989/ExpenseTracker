//
//  DashboardExpenseRepository.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation
// 1. Data Layer
protocol DashboardExpenseRepository{
    func fetchAllExpenses() -> [Expense]
}

class DashboardExpenseRepositoryImpl:DashboardExpenseRepository{
    
    func fetchAllExpenses() -> [Expense] {
        return Expense.all()
    }
    
}
