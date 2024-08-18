//
//  CategoryExpenseView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI
import Charts
struct CategoryExpenseView:View {
    @EnvironmentObject var viewModel: ExpenseSummaryViewModel
    let categoryExpense: [CategoryExpense]
    let expense:[ExpenseData]
    var body: some View {
        NavigationLink(destination: ExpenseSummary(expenseSummaryUseCase: viewModel.expenseSummaryUseCase, expense: expense)) {
            VStack(alignment:.leading){
                Text("Category Expense")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.top, 20)
                    .padding(.leading, 10)
                CategoryExpenseChart(categoryExpense: categoryExpense)
            }
            .padding()
        }
    }
}

struct CategoryExpenseChart:View {
    let categoryExpense: [CategoryExpense]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Chart(categoryExpense, id: \.category) { item in
                    SectorMark(
                        angle: .value("amount", item.amount)
                    )
                    .foregroundStyle(Color.color(for: item.category))
                }
                .padding()
                .frame(height: 250)
                .background(Color.clear)
                
                LegendView(categoryExpense: categoryExpense)
                    .padding()
            }
        }
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 5)
    }
}

struct LegendView: View {
    let categoryExpense: [CategoryExpense]
    
    private func percentage(for amount: Double, total: Double) -> String {
        guard total > 0 else { return "0" }
        let percentage = (amount / total) * 100
        return String(format: "%.1f", percentage)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(categoryExpense, id: \.category) { item in
                HStack {
                    Circle()
                        .fill(Color.color(for: item.category))
                        .frame(width: 10, height: 10)
                        .shadow(radius: 1)
                    Text("\(item.category): \(percentage(for: item.amount, total: totalAmount))")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.caption)
                        .foregroundStyle(Color(UIColor.label))
                }
            }
        }
        .padding()
    }
    
    private var totalAmount: Double {
        return categoryExpense.reduce(0) { $0 + $1.amount }
    }
}
