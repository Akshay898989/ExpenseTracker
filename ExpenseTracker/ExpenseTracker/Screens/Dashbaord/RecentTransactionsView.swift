//
//  RecentTransactionsView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI

struct RecentTransactionsView: View {
    let transactions: [TotalExpense]
    
    var body: some View {
        //NavigationView {
        VStack(alignment:.leading){
            HStack {
                Text("Recent Transactions")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: AllTransactionsView(transactions: transactions)) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            
            }
            .padding(10)
            
            ForEach(transactions.prefix(3)) {transaction in
                TransactionRow(transaction: transaction)
                Divider()
            }
            
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    //}
    }
}

struct TransactionRow: View {
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
        .padding(.horizontal,10)
        .background(Color.white)
        .cornerRadius(5)
    }
}


struct RecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTransactions = [
            TotalExpense(label: "Groceries", amount: 50.0, notes: "Milk and bread", date: Date()),
            TotalExpense(label: "Transport", amount: 20.0, notes: "Bus fare", date: Date()),
            TotalExpense(label: "Entertainment", amount: 100.0, notes: "Movie tickets", date: Date())
        ]
        
        RecentTransactionsView(transactions: sampleTransactions)
    }
}
