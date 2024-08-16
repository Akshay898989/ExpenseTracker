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
    init(viewModel: DashboardExpenseViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 0) {
            Text("Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top,10)
            TotalExpenseView(selectedInterval: $viewModel.selectedInterval, totalExpense: viewModel.totalExpense) { newInterval in
                viewModel.updateInterval(newInterval)
            }
            
            CategoryExpenseView(categoryExpense: viewModel.categoryExpense)
        }
        .onAppear {
            viewModel.getTotalExpense()
            viewModel.getCategoryExpense()
        }
    }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(viewModel: DashboardExpenseViewModel(dashboardExpenseUseCase: DashboardExpenseUseCase(repository: DashboardExpenseRepository())))
    }
}

