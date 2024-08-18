//
//  ExpenseSummaryViewModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 18/08/24.
//

import Foundation

class ExpenseSummaryViewModel: ObservableObject {
    @Published var sections: [ExpenseSummaryCategorySection] = []
    let expenseSummaryUseCase: ExpenseSummaryUseCase
    init(expenseSummaryUseCase: ExpenseSummaryUseCase, expenses: [ExpenseData]) {
            self.expenseSummaryUseCase = expenseSummaryUseCase
            self.sections = expenseSummaryUseCase.summarizeExpenses(expenses)
        }
    
    func toggleSection(_ section: ExpenseSummaryCategorySection) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index].isExpanded.toggle()
        }
    }
}
