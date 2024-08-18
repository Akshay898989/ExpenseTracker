//
//  ExpenseSummaryViewModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 18/08/24.
//

import Foundation

class ExpenseSummaryViewModel: ObservableObject {
    @Published var sections: [ExpenseSummaryCategorySection] = []
    
    init(expenses: [ExpenseData]) {
        let grouped = Dictionary(grouping: expenses) { $0.category }
        self.sections = grouped.map { ExpenseSummaryCategorySection(category: $0.key, expenses: $0.value) }
    }
    
    func toggleSection(_ section: ExpenseSummaryCategorySection) {
        if let index = sections.firstIndex(where: { $0.id == section.id }) {
            sections[index].isExpanded.toggle()
        }
    }
}
