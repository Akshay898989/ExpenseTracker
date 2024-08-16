//
//  DashboardExpenseUseCase.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation

enum Interval {
    case monthly
    case yearly

    var dateFormat: String {
        switch self {
        case .monthly:
            return "MMMM"
        case .yearly:
            return "yyyy"
        }
    }
}
// 2. Domain Layer

class DashboardExpenseUseCase {
    private let repository: ExpenseRepository
    private var expenses:[ExpenseData] = []
    init(repository: ExpenseRepository) {
        self.repository = repository
    }
    
    func execute() -> [ExpenseData] {
        expenses = repository.fetchAllExpenses().map(ExpenseData.init)
        return expenses
    }
    
//    func addExpense(amount: Double, category: String, date: Date, note: String?){
    func addExpense(){
        //repository.addExpense(amount: amount, category: category, date: date, note: note)
        let twoMonthsBackDate = Calendar.current.date(byAdding: .month, value: 0, to: Date())!
        repository.addExpense(amount: 400, category: "Food22", date: twoMonthsBackDate, note: "spent on food")
        //repository.addExpense(amount: 4000, category: "Sports", date: twoMonthsBackDate, note: "")
    }
    
    
    func getTotalExpense(for interval: Interval) -> [TotalExpense] {
        var expensesByInterval: [String: Double] = [:]
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = interval.dateFormat
        
        let now = Date()
        let startDate = calendar.date(byAdding: .month, value: -11, to: now)!
        
        for expense in expenses {
            let key: String
            switch interval {
            case .monthly:
                let expenseMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: expense.date))!
                guard expenseMonth >= startDate else { continue }
                key = dateFormatter.string(from: expense.date)
            case .yearly:
                key = String(calendar.component(.year, from: expense.date))
            }
            expensesByInterval[key, default: 0] += expense.amount
        }
        
        return expensesByInterval.map { TotalExpense(label: $0.key, amount: $0.value) }
    }
    
    func getCategoryExpense()->[CategoryExpense] {
        let categoryDict = Dictionary(grouping: expenses, by: { $0.category })
        let categoryExpenses = categoryDict.map { CategoryExpense(category: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }
        return categoryExpenses
    }
    
    func getRecentTransactions() -> [TotalExpense] {
        // Sort expenses by date in descending order and return the latest 3
        let sortedExpenses = expenses.sorted(by: { $0.createdAt > $1.createdAt })
        let latestTransactions = sortedExpenses.map { expense in
            TotalExpense(
                label: expense.category,
                amount: expense.amount,
                notes: expense.note,
                date: expense.date
            )
        }
        return latestTransactions
    }
    
}
