//
//  TotalExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import Foundation

//struct TotalExpense:Identifiable {
//    var id = UUID()
//    let label: String
//    let amount: Double
//    let notes:String?
//    
//}

import Foundation

struct TotalExpense: Identifiable {
    var id = UUID()
    let label: String
    let amount: Double
    let notes: String?
    let date: Date?

    // Computed property to return date as formatted string
    var formattedDate: String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    init(id: UUID = UUID(), label: String, amount: Double,notes:String? = nil,date:Date? = nil) {
        self.id = id
        self.label = label
        self.amount = amount
        self.notes = notes
        self.date = date
    }
}
