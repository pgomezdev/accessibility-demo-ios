//
//  Budget.swift
//  AccessibilityDemo
//

import Foundation

struct Budget: Identifiable {
    var id: String { String(month) }
    let month: Int
    let amount: Double
}
