//
//  ExpensesOverTime.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import SwiftUI

import SwiftUI
import Charts

struct ExpensesOverTimeView: View {
    let expensesOverTime: [TotalExpense]
    
    var body: some View {
        
        Text("Expenses Over Time")
            .font(.headline)
            .padding(.top,20)
            .padding(.leading,10)
        VStack {
            ExpensesOverTimeChart(expensesOverTime: expensesOverTime)
        }
        .background(Color.white)
        .padding()
        .shadow(radius: 5)
        
    }
}

struct ExpensesOverTimeChart:View {
    let expensesOverTime: [TotalExpense]
    
    var body: some View {
        VStack(alignment:.leading){
        Chart {
            ForEach(expensesOverTime) { expensesOverTime in
                LineMark(
                    x: .value("Date", expensesOverTime.date ?? Date()),
                    y: .value("Amount", expensesOverTime.amount)
                )
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisValueLabel()
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                AxisValueLabel()
            }
        }
        .frame(height: 200)
        .padding()
    }
    }
}

/*
struct ExpensesOverTimeView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTransactions = [
            TotalExpense(id: UUID(),label: "Groceries", amount: 50.0, notes: "Milk and bread", date: Date().addingTimeInterval(-86400 * 3)),
            TotalExpense(id: UUID(),label: "Transport", amount: 20.0, notes: "Bus fare", date: Date().addingTimeInterval(-86400 * 2)),
            TotalExpense(id: UUID(),label: "Entertainment", amount: 100.0, notes: "Movie tickets", date: Date().addingTimeInterval(-86400 * 1)),
            TotalExpense(id: UUID(),label: "Dining", amount: 60.0, notes: "Dinner out", date: Date())
        ]
        
        ExpensesOverTimeView(expensesOverTime: sampleTransactions)
    }
}

*/
