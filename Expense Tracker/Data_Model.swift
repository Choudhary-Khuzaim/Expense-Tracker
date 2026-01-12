//
//  Data_Model.swift
//  Expense Tracker
//
//  Created by pc on 2/28/25.
//

import Foundation

struct Expense: Identifiable, Codable {
    let id = UUID()
    var title: String
    var amount: Double
    var category: String
    let date: Date
}
