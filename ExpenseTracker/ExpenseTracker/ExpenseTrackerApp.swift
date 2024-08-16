//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 14/08/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let dashboardExpenseRepository: ExpenseRepository
    let dashboardExpenseUseCase: DashboardExpenseUseCase
    init() {
        dashboardExpenseRepository = DashboardExpenseRepository()
        dashboardExpenseUseCase = DashboardExpenseUseCase(repository: dashboardExpenseRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            Dashboard(viewModel: DashboardExpenseViewModel(dashboardExpenseUseCase: dashboardExpenseUseCase))
        }
    }
}
