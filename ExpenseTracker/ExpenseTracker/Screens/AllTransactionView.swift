//
//  AllTransactionView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI

struct AllTransactionsView: View {
    let transactions: [TotalExpense]
    
    var body: some View {
        List(transactions) { transaction in
            AllTransactionRow(transaction: transaction)
        }
        .navigationTitle("All Transactions")
        //.padding()
    }
}

struct AllTransactionRow: View {
    let transaction: TotalExpense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.label) // Category name
                    .font(.headline)
                if let notes = transaction.notes {
                    Text(notes) // Notes
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                if let date = transaction.date {
                    Text(transaction.formattedDate) // Formatted date
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Text("\(transaction.amount, format: .currency(code: "USD"))") // Amount
                .font(.headline)
        }
    }
}

struct AllTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTransactions = [
            TotalExpense(label: "Groceries", amount: 50.0, notes: "Milk and bread", date: Date()),
            TotalExpense(label: "Transport", amount: 20.0, notes: "Bus fare", date: Date()),
            TotalExpense(label: "Entertainment", amount: 100.0, notes: "Movie tickets", date: Date())
        ]
        
        AllTransactionsView(transactions: sampleTransactions)
    }
}
