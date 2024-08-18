//
//  RecentTransactionsView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI

struct RecentTransactionsView: View {
    @EnvironmentObject var viewModel: DashboardExpenseViewModel
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text("Recent Transactions")
                    .foregroundColor(Color(UIColor.label))
                    .font(.headline)
                Spacer()
                NavigationLink(destination: AllTransactionsView()
                    .environmentObject(viewModel)
                ) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            
            }
            .padding(10)
            
            ForEach(viewModel.recentTransactions.prefix(3)) {transaction in
                TransactionRow(transaction: transaction)
                Divider()
            }
            
        }
        .padding(10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct TransactionRow: View {
    let transaction: TotalExpense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.category)
                    .foregroundColor(Color(UIColor.label))
                    .font(.headline)
                if let notes = transaction.notes {
                    Text(notes) // Notes
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                if let date = transaction.date {
                    Text(transaction.formattedDate)
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
            Spacer()
            Text("\(transaction.amount, format: .currency(code: "USD"))") // Amount
                .font(.headline)
                .foregroundColor(Color(UIColor.label))
        }
        .padding(.horizontal,10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(5)
    }
}


//struct RecentTransactionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleTransactions = [
//            TotalExpense(id: UUID(), label: "Groceries", amount: 50.0, notes: "Milk and bread", date: Date()),
//            TotalExpense(id: UUID(),label: "Transport", amount: 20.0, notes: "Bus fare", date: Date()),
//            TotalExpense(id: UUID(),label: "Entertainment", amount: 100.0, notes: "Movie tickets", date: Date())
//        ]
//        
//        RecentTransactionsView(transactions: sampleTransactions)
//    }
//}
