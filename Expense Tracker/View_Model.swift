//
//  View_Model.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = [] {
        didSet {
            saveExpenses()
        }
    }

    init() {
        loadExpenses()
    }

    init(forPreview: Bool) {
        if forPreview {
            expenses = [
                Expense(title: "Groceries", amount: 50.0, category: "Food", date: Date()),
                Expense(title: "Gas", amount: 30.0, category: "Travel", date: Date()),
                Expense(title: "Movie", amount: 15.0, category: "Entertainment", date: Date())
            ]
        }
    }

    func addExpense(title: String, amount: Double, category: String, date: Date) {
        let newExpense = Expense(title: title, amount: amount, category: category, date: date)
        expenses.append(newExpense)
    }

    func editExpense(id: UUID, title: String, amount: Double, category: String) {
        if let index = expenses.firstIndex(where: { $0.id == id }) {
            expenses[index].title = title
            expenses[index].amount = amount
            expenses[index].category = category
        }
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    func filterExpenses(by category: String) -> [Expense] {
        expenses.filter { $0.category == category }
    }

    private func saveExpenses() {
        if let encodedData = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encodedData, forKey: "expenses")
        }
    }

    private func loadExpenses() {
        if let savedData = UserDefaults.standard.data(forKey: "expenses"),
           let decodedExpenses = try? JSONDecoder().decode([Expense].self, from: savedData) {
            expenses = decodedExpenses
        }
    }

    func totalSpending() -> Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
}
