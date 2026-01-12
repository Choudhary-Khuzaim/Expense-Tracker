//
//  ContentView.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ExpenseViewModel()
    @State private var showingAddExpense = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationStack {
            TabView {
                
                ExpenseListView(viewModel: viewModel)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                Expense_History_View(viewModel: viewModel)
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }

                ExpenseChartView(viewModel: viewModel)
                    .tabItem {
                        Label("Charts", systemImage: "chart.bar")
                    }
            }
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                Add_Expense_View(viewModel: viewModel)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light) 
        }
    }
}

#Preview {
    ContentView()
}
