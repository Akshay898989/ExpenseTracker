import SwiftUI

struct ShowFilterScreen: View {
    @EnvironmentObject var viewModel: DashboardExpenseViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var selectedCategory: String = "All"
    private let categories = ["Food", "Transport", "Utilities", "Entertainment", "Others"]
    init() {
        let today = Date()
        let calendar = Calendar.current
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: today) ?? today
        
        _startDate = State(initialValue: oneMonthAgo)
        _endDate = State(initialValue: today)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filter by date range")) {
                    DatePicker("Start date", selection: $startDate,in: ...Date(), displayedComponents: .date)
                    DatePicker("End date", selection: $endDate,in: startDate...Date(), displayedComponents: .date)
                    HStack {
                        Spacer()
                        Button("Filter") {
                            viewModel.getFilterTransactions(byStartDate: startDate, endDate: endDate)
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                    
                }
                
                
                Section(header: Text("Filter By Category")) {
                    Picker("Select category", selection: $selectedCategory) {
                        Text("All").tag("")
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    HStack {
                        Spacer()
                        Button("Filter") {
                            viewModel.getFilterTransactions(byStartDate: nil, endDate: nil,category: selectedCategory)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
            }
            .navigationTitle("Filter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

extension String {
    func asDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}

