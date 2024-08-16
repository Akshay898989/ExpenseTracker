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
        VStack(alignment:.leading){
            Chart(categoryExpense, id: \.category) { item in
                SectorMark(
                    angle: .value("Count", item.amount)
                )
                .foregroundStyle(by: .value("Category", item.category))
            }
            .padding()
            .frame(height: 250)
            .background(Color.white)
            .shadow(radius: 5)
        }
    }
}
