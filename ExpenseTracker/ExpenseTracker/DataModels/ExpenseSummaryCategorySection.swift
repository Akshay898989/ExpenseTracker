//
//  ExpenseSummaryCategorySection.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 18/08/24.
//

import Foundation

struct ExpenseSummaryCategorySection: Identifiable {
    let id = UUID()
    let category: String
    let expenses: [ExpenseData]
    var isExpanded: Bool = false
    
    var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
}
