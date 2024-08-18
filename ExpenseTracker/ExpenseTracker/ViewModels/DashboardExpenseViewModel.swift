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
    @Published var filteredTransactions: [TotalExpense] = []
    private let dashboardExpenseUseCase: DashboardExpenseUseCase
    private let dashboardCSVExporterUseCase:DashboardCSVExporterUseCase
    init(dashboardExpenseUseCase: DashboardExpenseUseCase,dashboardCSVExporterUseCase:DashboardCSVExporterUseCase) {
        self.dashboardExpenseUseCase = dashboardExpenseUseCase
        self.dashboardCSVExporterUseCase = dashboardCSVExporterUseCase
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
    
    func getFilterTransactions(byStartDate startDate: Date?, endDate: Date?,category:String = "") {
        if let startDate = startDate, let endDate = endDate {
            filteredTransactions = recentTransactions.filter { transaction in
                guard let transactionDate = transaction.date else { return false }
                return transactionDate >= startDate && transactionDate <= endDate
            }
        } else if !category.isEmpty && category != "All"{
            filteredTransactions = recentTransactions.filter{$0.category == category}
        } else{
            filteredTransactions = recentTransactions
        }
    }
    
    func resetFilter(){
        filteredTransactions = recentTransactions
    }
    
    func exportDataToCSV()->URL?{
        return dashboardCSVExporterUseCase.exportDataToCSV(expenses: recentTransactions)
    }
}
