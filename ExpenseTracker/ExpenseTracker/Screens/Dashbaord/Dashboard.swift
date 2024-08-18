//
//  Dashboard.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import SwiftUI
import Charts

struct Dashboard: View {
    @StateObject private var viewModel:DashboardExpenseViewModel
    //@EnvironmentObject private var addExpenseViewModel: AddExpenseViewModel
    @State private var didSaveExpense = false
    init(viewModel: DashboardExpenseViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        if viewModel.recentTransactions.count>0{
                            TotalExpenseView(selectedInterval: $viewModel.selectedInterval, totalExpense: viewModel.totalExpense) { newInterval in
                                viewModel.updateInterval(newInterval)
                            }
                            CategoryExpenseView(categoryExpense: viewModel.categoryExpense,expense:viewModel.expense)
                            if viewModel.recentTransactions.count>1{
                                ExpensesOverTimeView(expensesOverTime: viewModel.recentTransactions)
                            }
                            RecentTransactionsView()
                                .environmentObject(viewModel)
                                .padding(10)
                        }else{
                            VStack {
                                Spacer()
                                Text("No Data Present")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .navigationTitle("Expense Tracker")
                    .onChange(of: didSaveExpense) { _ in
                        viewModel.loadData()  // Reload data when returning from AddExpenseView
                        didSaveExpense = false  // Reset the flag after reload
                    }
                    .onAppear {
                        viewModel.loadData()
                    }
                    
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddExpenseView(didSaveExpense: $didSaveExpense)){
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            
                                .padding()
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(viewModel: DashboardExpenseViewModel(dashboardExpenseUseCase: DashboardExpenseUseCase(repository: DashboardExpenseRepository())))
    }
}

