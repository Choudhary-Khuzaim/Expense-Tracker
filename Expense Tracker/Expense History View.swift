//
//  Expense History View.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import SwiftUI

struct Expense_History_View: View {
    @ObservedObject var viewModel: ExpenseViewModel

    var body: some View {
        List {
            ForEach(viewModel.expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.title)
                        .font(.headline)
                    Text("\(expense.amount, format: .currency(code: "USD")) • \(expense.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(expense.date, format: .dateTime.day().month().year())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Expense History")
    }
}

#Preview {
    Expense_History_View(viewModel: ExpenseViewModel())
}
