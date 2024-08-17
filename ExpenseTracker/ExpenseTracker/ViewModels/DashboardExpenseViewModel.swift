//
//  DashboardExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 15/08/24.
//

import Foundation
import SwiftUI
class DashboardExpenseViewModel:ObservableObject{
    @Published var expense:[ExpenseData] = [ExpenseData]()
    @Published var totalExpense:[TotalExpense] = []
    @Published var categoryExpense:[CategoryExpense] = [CategoryExpense]()
    @Published var selectedInterval: Interval = .monthly
    @Published var recentTransactions: [TotalExpense] = []
    private let dashboardExpenseUseCase: DashboardExpenseUseCase
    
    init(dashboardExpenseUseCase: DashboardExpenseUseCase) {
        self.dashboardExpenseUseCase = dashboardExpenseUseCase
        //loadData()
    }
    
    func loadData() {
        expense = dashboardExpenseUseCase.execute()
        getTotalExpense()
        getCategoryExpense()
        getRecentTransactions()
    }
    
    
    func getTotalExpense(){
        totalExpense = dashboardExpenseUseCase.getTotalExpense(for: selectedInterval)
    }
    func getCategoryExpense(){
        categoryExpense = dashboardExpenseUseCase.getCategoryExpense()
    }
    func updateInterval(_ interval: Interval) {
        selectedInterval = interval
        getTotalExpense()
    }
    func getRecentTransactions(){
        recentTransactions = dashboardExpenseUseCase.getRecentTransactions()
    }
}
