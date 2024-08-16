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




/*
To implement the first screen (the Dashboard screen) in your Expense Tracker app following Clean Architecture, here’s how you can structure it:

### *1. Presentation Layer (SwiftUI View)*
The Presentation Layer handles displaying the data to the user. In SwiftUI, this will be the DashboardView that shows the pie chart, line graph, and top 3 expenses.

swift
import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        VStack {
            // Header: Total Expenses Summary
            Text("Total Expenses: \(viewModel.totalExpenses, specifier: "%.2f")")
                .font(.largeTitle)
                .padding()

            // Pie Chart: Expenses by Category
            PieChartView(categories: viewModel.expenseCategories)
                .frame(height: 200)
                .padding()

            // Line Graph: Expenses Over Time
            LineGraphView(dataPoints: viewModel.expenseOverTime)
                .frame(height: 200)
                .padding()

            // Top 3 Expenses
            Text("Top 3 Expenses")
                .font(.headline)
                .padding(.top)
            
            List(viewModel.topExpenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.category)
                        .font(.headline)
                    Text("\(expense.amount, specifier: "%.2f") - \(expense.dateFormatted)")
                }
            }
        }
        .onAppear {
            viewModel.loadDashboardData()
        }
    }
}


### *2. ViewModel (Presentation Layer)*
The DashboardViewModel is responsible for preparing the data to be displayed on the DashboardView. It interacts with the domain layer (via use cases) to fetch the data.

swift
import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var totalExpenses: Double = 0.0
    @Published var expenseCategories: [CategoryExpense] = []
    @Published var expenseOverTime: [ExpenseOverTime] = []
    @Published var topExpenses: [Expense] = []
    
    private let getDashboardDataUseCase: GetDashboardDataUseCase
    
    init(getDashboardDataUseCase: GetDashboardDataUseCase) {
        self.getDashboardDataUseCase = getDashboardDataUseCase
    }
    
    func loadDashboardData() {
        let dashboardData = getDashboardDataUseCase.execute()
        totalExpenses = dashboardData.totalExpenses
        expenseCategories = dashboardData.expenseCategories
        expenseOverTime = dashboardData.expenseOverTime
        topExpenses = dashboardData.topExpenses
    }
}


### *3. Domain Layer*
In the domain layer, you define the business logic. The GetDashboardDataUseCase aggregates data required for the dashboard.

swift
import Foundation

struct DashboardData {
    let totalExpenses: Double
    let expenseCategories: [CategoryExpense]
    let expenseOverTime: [ExpenseOverTime]
    let topExpenses: [Expense]
}

class GetDashboardDataUseCase {
    private let expenseRepository: ExpenseRepository
    
    init(expenseRepository: ExpenseRepository) {
        self.expenseRepository = expenseRepository
    }
    
    func execute() -> DashboardData {
        let expenses = expenseRepository.getAllExpenses()
        
        let totalExpenses = expenses.reduce(0) { $0 + $1.amount }
        
        let expenseCategories = calculateExpensesByCategory(expenses: expenses)
        let expenseOverTime = calculateExpensesOverTime(expenses: expenses)
        let topExpenses = calculateTopExpenses(expenses: expenses)
        
        return DashboardData(totalExpenses: totalExpenses, expenseCategories: expenseCategories, expenseOverTime: expenseOverTime, topExpenses: topExpenses)
    }
    
    private func calculateExpensesByCategory(expenses: [Expense]) -> [CategoryExpense] {
        // Implementation to calculate expenses by category
    }
    
    private func calculateExpensesOverTime(expenses: [Expense]) -> [ExpenseOverTime] {
        // Implementation to calculate expenses over time
    }
    
    private func calculateTopExpenses(expenses: [Expense]) -> [Expense] {
        // Implementation to find the top 3 expenses
    }
}


### *4. Data Layer*
The Data Layer provides the concrete implementation for data access. This could involve fetching data from Core Data, a remote API, or another data source.

swift
import Foundation

class CoreDataExpenseRepository: ExpenseRepository {
    func getAllExpenses() -> [Expense] {
        // Core Data implementation to fetch all expenses
    }
    
    // Other methods...
}


### *Connecting Everything Together*
When initializing the DashboardView, you need to inject the dependencies properly. This involves setting up the repository and use case.

swift
let coreDataService = CoreDataService()
let expenseRepository = CoreDataExpenseRepository(coreDataService: coreDataService)
let getDashboardDataUseCase = GetDashboardDataUseCase(expenseRepository: expenseRepository)
let dashboardViewModel = DashboardViewModel(getDashboardDataUseCase: getDashboardDataUseCase)

let dashboardView = DashboardView(viewModel: dashboardViewModel)


### *Summary*
- *UI (Presentation Layer)*: Displays data and interacts with the ViewModel.
- *ViewModel*: Fetches and prepares data for the view by using the use case.
- *Domain Layer*: Contains the business logic and use cases that fetch and aggregate data from the repository.
- *Data Layer*: Provides the actual data, implementing the repository interface to fetch data from the desired source (e.g., Core Data).

This architecture ensures your app is modular, testable, and easy to maintain. Each layer has a clear responsibility, making it easier to modify or extend individual components without affecting the entire system.
*/
