//
//  CategoryExpenseView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI
import Charts
struct CategoryExpenseView:View {
    let categoryExpense: [CategoryExpense]
    var body: some View {
        Text("Category Expense")
            .font(.headline)
            .padding(.top,20)
            .padding(.leading,10)
        VStack{
            CategoryExpenseChart(categoryExpense: categoryExpense)
        }
        .padding()
    }
}

struct CategoryExpenseChart:View {
    let categoryExpense: [CategoryExpense]
    var body: some View {
        let totalAmount = categoryExpense.reduce(0) { $0 + $1.amount }
        VStack(alignment:.leading){
            Chart(categoryExpense, id: \.category) { item in
                SectorMark(
                    angle: .value("amount", item.amount)
//                    innerRadius: .ratio(0.6),
//                    angularInset: 2
                )
                .foregroundStyle(by: .value("Category", item.category))
                .annotation(position: .overlay) {
                    Text("\(percentage(for: item.amount, total: totalAmount))")
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                        .shadow(radius: 5)
                }
            }
            .chartLegend(alignment: .center, spacing: 16)
            .padding()
            .frame(height: 250)
            .background(Color.white)
            .shadow(radius: 5)
        }
    }
    
    private func percentage(for amount: Double, total: Double) -> String {
            guard total > 0 else { return "0" }
            let percentage = (amount / total) * 100
            return String(format: "%.1f", percentage)
        }
}
