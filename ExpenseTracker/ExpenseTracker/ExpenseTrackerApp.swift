//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 14/08/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let dashboardExpenseRepository: DashboardExpenseRepository
    let dashboardExpenseUseCase: DashboardExpenseUseCase
    let addExpenseRepository: AddExpenseRepository
    let addExpenseUseCase: AddExpenseUseCase
    init() {
        dashboardExpenseRepository = DashboardExpenseRepositoryImpl()
        dashboardExpenseUseCase = DashboardExpenseUseCase(repository: dashboardExpenseRepository)
        addExpenseRepository = AddExpenseRepositoryImpl()
        addExpenseUseCase = AddExpenseUseCase(repository: addExpenseRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            Dashboard(viewModel: DashboardExpenseViewModel(dashboardExpenseUseCase: dashboardExpenseUseCase))
                .environmentObject(AddExpenseViewModel(addExpenseUseCase: addExpenseUseCase))
        }
    }
}
