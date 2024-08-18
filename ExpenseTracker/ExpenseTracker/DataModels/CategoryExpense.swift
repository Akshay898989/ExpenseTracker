//
//  CategoryExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import Foundation
import SwiftUI

struct CategoryExpense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

extension Color {
    static func color(for category: String) -> Color {
        switch category {
        case "Food":
            return .blue
        case "Transport":
            return .red
        case "Entertainment":
            return .green
        case "Utilities":
            return .orange
        case "Other":
            return .purple
        // Add more categories and colors as needed
        default:
            return .gray
        }
    }
}
