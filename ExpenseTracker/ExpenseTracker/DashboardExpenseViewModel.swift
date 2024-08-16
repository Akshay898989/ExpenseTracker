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
    private let dashboardExpenseUseCase: DashboardExpenseUseCase
    
    init(dashboardExpenseUseCase: DashboardExpenseUseCase) {
        self.dashboardExpenseUseCase = dashboardExpenseUseCase
        //addExpense()
        loadData()
    }
    
    func loadData() {
        expense = dashboardExpenseUseCase.execute()
    }
    
    func addExpense(){
        dashboardExpenseUseCase.addExpense()
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
}
