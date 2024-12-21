//
//  InboxMessage.swift
//  AccessibilityDemo
//

import Foundation

enum InboxMessageType: String {
    case information, warning, payment, income
    
    var accessibilityLabel: String {
        switch self {
        case .information: return NSLocalizedString("inbox.message.type.information", comment: "Information type message")
        case .warning: return NSLocalizedString("inbox.message.type.warning", comment: "Warning type message")
        case .payment: return NSLocalizedString("inbox.message.type.payment", comment: "Payment type message")
        case .income: return NSLocalizedString("inbox.message.type.income", comment: "Income type message")
        }
    }
}

struct InboxMessage: Identifiable {
    let id: String
    let type: InboxMessageType
    let message: String
    let date: Date
}
