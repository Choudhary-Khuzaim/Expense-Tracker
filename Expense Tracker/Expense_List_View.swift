//
//  Expense_List_View.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var showTotalSpending = true // State to control visibility of total spending

    var body: some View {
        ZStack {
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
                .onDelete(perform: viewModel.deleteExpense)
            }

            // Total Spending Overlay
            if showTotalSpending {
                VStack {
                    Spacer()
                    HStack {
                        Text("Total Spending: \(viewModel.totalSpending(), format: .currency(code: "USD"))")
                            .font(.title2)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 5)

                        // Cross Button to hide the overlay
                        Button(action: {
                            withAnimation {
                                showTotalSpending = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                }
                .padding()
            }

            // Side Button to show the overlay
            if !showTotalSpending {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showTotalSpending = true
                            }
                        }) {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle("Expenses")
    }
}

#Preview {
    ExpenseListView(viewModel: ExpenseViewModel(forPreview: true))
}
