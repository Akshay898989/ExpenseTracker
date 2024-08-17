//
//  AddExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import Foundation
import Combine

class AddExpenseViewModel:ObservableObject{
    @Published var amount: String = ""
    @Published var category: String = ""
    @Published var date = Date()
    @Published var note: String = ""
    @Published var isSaveButtonEnabled: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let addExpenseUseCase: AddExpenseUseCase
    init(addExpenseUseCase:AddExpenseUseCase){
        self.addExpenseUseCase = addExpenseUseCase
        setupValidation()
    }
    
    private func setupValidation() {
        Publishers.CombineLatest($amount, $category)
            .map { amount, category in
                let amountValue = Double(amount) ?? 0.0
                return !amount.isEmpty && amountValue > 0 && !category.isEmpty
            }
            .assign(to: &$isSaveButtonEnabled)
    }
    
    func addExpense(completion:@escaping(Bool)->Void){
        addExpenseUseCase.addExpense(amount: Double(amount)!, category: category, date: date, note: note){result in
            completion(result)
        }
    }
    
    func update(expenseId:UUID,completion:@escaping(Bool)->Void){
        addExpenseUseCase.updateExpense(expenseId:expenseId,amount: Double(amount)!, category: category, date: date, note: note){result in
            completion(result)
        }
    }
    func reset() {
        amount = ""
        category = ""
        date = Date()
        note = ""
        isSaveButtonEnabled = false
    }
}
