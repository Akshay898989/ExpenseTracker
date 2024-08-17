//
//  TotalExpenseView.swift
//  ExpenseTracker
//
//  Created by akshaygupta on 16/08/24.
//

import SwiftUI
import Charts
struct TotalExpenseView:View {
    @Binding var selectedInterval: Interval
    let totalExpense: [TotalExpense]
    let onIntervalChange: (Interval) -> Void
    var body: some View {
        Text("Total Expenses")
            .font(.headline)
            .padding(.top,20)
            .padding(.leading,10)
        VStack{
            HStack {
                Picker("Select Interval", selection: $selectedInterval) {
                    Text("Monthly").tag(Interval.monthly)
                    Text("Yearly").tag(Interval.yearly)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
                .padding()
            }
            .onChange(of: selectedInterval, { oldValue, newValue in
                onIntervalChange(newValue)
            })
    
            TotalExpenseChart(totalExpense: totalExpense)
            
        }
        .background(Color.white)
        .padding()
        .shadow(radius: 5)
    }
}


struct TotalExpenseChart:View{
    let totalExpense: [TotalExpense]
    var body: some View{
        VStack(alignment: .leading){
            Chart {
                ForEach(totalExpense) { expense in
                    BarMark(
                        x: .value("Label", expense.label),
                        y: .value("Amount", expense.amount)
                    )
                    .annotation(position: .top){
                        Text("\(expense.amount, format: .number.precision(.fractionLength(2)))")
                            .frame(minWidth: 2)
                            .font(.caption2)
                    }
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .bottom,
                        endPoint: .top
                    ))
                    
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                }
            }
            .frame(height: 200)
            .padding()
            
        }
    }
    
    
}
