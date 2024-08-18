//
//  ExpenseSummaryUseCase.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 18/08/24.
//

import Foundation

class ExpenseSummaryUseCase{
    func summarizeExpenses(_ expenses: [ExpenseData]) -> [ExpenseSummaryCategorySection] {
        let grouped = Dictionary(grouping: expenses) { $0.category }
        return grouped.map { ExpenseSummaryCategorySection(category: $0.key, expenses: $0.value) }
    }
}
