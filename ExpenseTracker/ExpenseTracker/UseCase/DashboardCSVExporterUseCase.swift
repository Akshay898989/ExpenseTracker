//
//  DashboardCSVExporterUseCase.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 19/08/24.
//

import Foundation
import SwiftUI
class DashboardCSVExporterUseCase{
    
    func exportDataToCSV(expenses:[TotalExpense])->URL? {
        // Create a temporary file URL for the CSV file
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileURL = tempDirectory.appendingPathComponent("ExpenseData.csv")
        
        // Generate CSV data and write it to the temporary file
        let csvData = Data(generateCSV(from: expenses).utf8)
        do {
            try csvData.write(to: tempFileURL)
            print("Temporary CSV file saved to: \(tempFileURL)")
        } catch {
            print("Error writing temporary CSV file: \(error)")
            return nil
        }
        return tempFileURL
    }
    
    func generateCSV(from expenses: [TotalExpense]) -> String {
        var csvString = "Category,Amount,Date,Notes\n" // Header row
        
        for expense in expenses {
            let category = expense.category
            let amount = String(format: "%.2f", expense.amount)
            let date = expense.formattedDate
            let notes = expense.notes?.replacingOccurrences(of: ",", with: ";") ?? "" // Replace commas to avoid breaking CSV format
            let newLine = "\(category),\(amount),\(date),\(notes)\n"
            csvString.append(newLine)
        }
        
        return csvString
    }
}
