//
//  AllTransactionView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case showFilters
}

struct AllTransactionsView: View {
    @EnvironmentObject var viewModel: DashboardExpenseViewModel
    @State private var didUpdateExpense = false
    @State private var showFilter:Sheets?
    var body: some View {
        List(viewModel.filteredTransactions) { transaction in
            NavigationLink(destination:AddExpenseView(didSaveExpense: $didUpdateExpense, expenseToEdit: transaction)){
                AllTransactionRow(transaction: transaction)
            }
            .onChange(of: didUpdateExpense) { oldValue, newValue in
                viewModel.getRecentTransactions()
                didUpdateExpense = false
            }
            
        }
        .onAppear(){
            viewModel.getFilterTransactions(byStartDate: nil, endDate: nil)
        }
        .navigationTitle("All Transactions")
        .toolbar{
            Button("Filter"){
                showFilter = .showFilters
            }
        }
        .sheet(item: $showFilter, onDismiss: {
        }, content: { item in
            switch item {
                case .showFilters:
                ShowFilterScreen()

            }
        })
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

//struct AllTransactionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleTransactions = [
//            TotalExpense(id: UUID(),label: "Groceries", amount: 50.0, notes: "Milk and bread", date: Date()),
//            TotalExpense(id: UUID(),label: "Transport", amount: 20.0, notes: "Bus fare", date: Date()),
//            TotalExpense(id: UUID(),label: "Entertainment", amount: 100.0, notes: "Movie tickets", date: Date())
//        ]
//        
//        AllTransactionsView(transactions: sampleTransactions)
//    }
//}
