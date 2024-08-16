//
//  CategoryExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import Foundation

struct CategoryExpense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}
