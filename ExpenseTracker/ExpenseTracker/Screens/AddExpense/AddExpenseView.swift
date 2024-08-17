//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 17/08/24.
//

import SwiftUI

import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject var viewModel: AddExpenseViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var showAlert = false
    @Binding var didSaveExpense: Bool
//    init(viewModel: AddExpenseViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
    
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
                    viewModel.reset()
                    // Pre-select the first category if not set
                    if viewModel.category.isEmpty {
                        viewModel.category = categories.first ?? ""
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
                        viewModel.addExpense { success in
                            if success {
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Save")
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
                    message: Text("Expense saved successfully."),
                    dismissButton: .default(Text("OK"), action: {
                        didSaveExpense = true
                        presentationMode.wrappedValue.dismiss()
                    })
                )
            })
        }
        .navigationTitle("Add Expense")
    }
}

//struct AddExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        AddExpenseView(viewModel: AddExpenseViewModel(addExpenseUseCase: AddExpenseUseCase(repository: AddExpenseRepositoryImpl())))
//    }
//}
