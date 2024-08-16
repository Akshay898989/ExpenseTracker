//
//  ExpenseData.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import Foundation

struct ExpenseData{
    let expense:Expense
    
    var id: UUID{
        return expense.id!
    }
    var amount:Double{
        return expense.amount
    }
    var category:String{
        return expense.category ?? ""
    }
    var date:Date{
        return expense.date!
    }
    var createdAt:Date{
        return expense.createdAt!
    }
    var note:String?{
        return expense.note
    }
}
