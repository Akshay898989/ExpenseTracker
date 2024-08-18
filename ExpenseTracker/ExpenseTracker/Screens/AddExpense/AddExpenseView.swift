//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject var viewModel: AddExpenseViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var showAlert = false
    @Binding var didSaveExpense: Bool
    var expenseToEdit: TotalExpense?
    var categories = ["Food", "Transport", "Utilities", "Entertainment", "Others"]
    
    var body: some View {
        VStack(alignment:.leading){
            Form {
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Select category", selection: $viewModel.category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                .onAppear {
                    if let expense = expenseToEdit {
                        viewModel.amount = "\(expense.amount)"
                        viewModel.category = expense.category
                        viewModel.date = expense.date!
                        viewModel.note = expense.notes ?? ""
                        viewModel.isSaveButtonEnabled = true
                    }else{
                        viewModel.reset()
                        // Pre-select the first category if not set
                        if viewModel.category.isEmpty {
                            viewModel.category = categories.first ?? ""
                        }
                    }
                    
                }
                
                
                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $viewModel.date,in: ...Date(), displayedComponents: .date)
                }
                
                Section(header: Text("Note")) {
                    TextField("Enter note (optional)", text: $viewModel.note)
                }
                Section(footer:
                            HStack {
                    Spacer()
                    Button(action: {
                        if expenseToEdit == nil{
                            viewModel.addExpense { success in
                                if success {
                                    showAlert = true
                                }
                            }
                        }else{
                            viewModel.update(expenseId: expenseToEdit!.id!) { success in
                                if success {
                                    showAlert = true
                                }
                            }
                        }
                    }) {
                        Text(expenseToEdit == nil ? "Save" : "Update")
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 40)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(viewModel.isSaveButtonEnabled ? 1.0 : 0.5)
                    }
                    .disabled(!viewModel.isSaveButtonEnabled)
                    Spacer()
                }
                ){
                    EmptyView()
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Success"),
                    message: Text(expenseToEdit == nil ? "Expense saved successfully." : "Expense updated successfully."),
                    dismissButton: .default(Text("OK"), action: {
                        didSaveExpense = true
                        presentationMode.wrappedValue.dismiss()
                    })
                )
            })
        }
        .navigationTitle(expenseToEdit == nil ? "Add Expense" : "Edit Expense")
    }
}
