//
//  InboxMessage.swift
//  AccessibilityDemo
//

import Foundation

enum InboxMessageType: String {
    case information, warning, payment, income
}

struct InboxMessage: Identifiable {
    let id: String
    let type: InboxMessageType
    let message: String
    let date: Date
}
