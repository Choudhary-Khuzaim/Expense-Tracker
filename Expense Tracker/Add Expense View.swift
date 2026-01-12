//
//  Add Expense View.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import SwiftUI

struct Add_Expense_View: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var category = "Food"
    @State private var date = Date()

    let categories = ["Food", "Travel", "Entertainment", "Shopping", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let amountValue = Double(amount) {
                            viewModel.addExpense(title: title, amount: amountValue, category: category, date: date)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || amount.isEmpty)
                }
            }
        }
    }
}

#Preview {
    Add_Expense_View(viewModel: ExpenseViewModel()) // Pass the ViewModel here
}
