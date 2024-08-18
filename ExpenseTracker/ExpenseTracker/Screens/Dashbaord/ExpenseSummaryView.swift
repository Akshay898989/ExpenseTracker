//
//  ExpenseSummaryView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 18/08/24.
//

import SwiftUI

import SwiftUI

struct ExpenseSummary: View {
    @StateObject var viewModel: ExpenseSummaryViewModel
    init(expenseSummaryUseCase: ExpenseSummaryUseCase, expense:[ExpenseData]) {
        _viewModel = StateObject(wrappedValue: ExpenseSummaryViewModel(expenseSummaryUseCase: expenseSummaryUseCase, expenses: expense))
    }
    var body: some View {
        VStack{
            List {
                ForEach(viewModel.sections) { section in
                    Section(header: sectionHeader(for: section)) {
                        if section.isExpanded {
                            ForEach(section.expenses, id: \.id) { expense in
                                HStack{
                                    Text(expense.date, style: .date)
                                        .font(.caption)
                                    Spacer()
                                    Text("$\(expense.amount, specifier: "%.2f")")
                                        .bold()
                                }
                            }
                        }
                    }
                    .padding(0)
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Grouped Categories")
        
    }
    
    private func sectionHeader(for section: ExpenseSummaryCategorySection) -> some View {
        Button(action: {
            viewModel.toggleSection(section)
        }) {
            HStack {
                Text(section.category)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("Total: $\(section.totalAmount, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(.black)
                Image(systemName: section.isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.black)
            }
            .padding(0)
            .cornerRadius(10)
        }
    }
}
