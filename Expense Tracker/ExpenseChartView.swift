//
//  ExpenseChartView.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import SwiftUI
import Charts

struct ExpenseChartView: View {
    @ObservedObject var viewModel: ExpenseViewModel

    var body: some View {
        VStack {
            // Chart Title
            Text("Spending by Category")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            // Chart
            Chart(viewModel.expenses) { expense in
                BarMark(
                    x: .value("Category", expense.category),
                    y: .value("Amount", expense.amount)
                )
                .foregroundStyle(by: .value("Category", expense.category)) // Color by category
                .annotation(position: .top) { // Add amount labels on top of bars
                    Text(expense.amount.formatted(.currency(code: "USD"))) // Corrected currency formatting
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .chartForegroundStyleScale([
                "Food": .blue,
                "Travel": .green,
                "Entertainment": .orange,
                "Shopping": .purple,
                "Other": .red
            ]) // Custom colors for each category
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine() // Add grid lines
                    AxisValueLabel() // Add X-axis labels
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine() // Add grid lines
                    AxisValueLabel() // Add Y-axis labels
                }
            }
            .frame(height: 300) // Set a fixed height for the chart
            .padding()

            // Legend
            HStack(spacing: 20) {
                ForEach(Array(Set(viewModel.expenses.map { $0.category })), id: \.self) { category in
                    HStack {
                        Circle()
                            .fill(colorForCategory(category))
                            .frame(width: 10, height: 10)
                        Text(category)
                            .font(.caption)
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Spending Analysis")
        .padding()
    }

    // Helper function to get color for a category
    private func colorForCategory(_ category: String) -> Color {
        switch category {
        case "Food": return .blue
        case "Travel": return .green
        case "Entertainment": return .orange
        case "Shopping": return .purple
        default: return .red
        }
    }
}

#Preview {
    ExpenseChartView(viewModel: ExpenseViewModel(forPreview: true))
}
