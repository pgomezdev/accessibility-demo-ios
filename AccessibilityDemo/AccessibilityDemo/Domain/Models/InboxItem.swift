//
//  InboxItem.swift
//  AccessibilityDemo
//

import Foundation

enum InboxItemType: String {
    case information, warning, payment, income
}

struct InboxItem: Identifiable {
    let id: String
    let type: InboxItemType
    let message: String
    let date: Date
}
