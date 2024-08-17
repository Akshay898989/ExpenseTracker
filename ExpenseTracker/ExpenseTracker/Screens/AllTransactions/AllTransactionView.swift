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
    }
}

struct AllTransactionRow: View {
    let transaction: TotalExpense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.label)
                    .font(.headline)
                if let notes = transaction.notes {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                    Text(transaction.formattedDate)
                        .font(.caption)
                        .foregroundColor(.gray)
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
