//
//  TotalExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import Foundation

struct TotalExpense:Identifiable {
    var id = UUID()
    let label: String
    let amount: Double
}
