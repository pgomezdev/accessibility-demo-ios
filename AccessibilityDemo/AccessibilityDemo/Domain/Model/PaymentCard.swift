//
//  PaymentCard.swift
//  AccessibilityDemo
//

import Foundation

enum PaymentCardType: String {
    case visa, masterCard
}

struct PaymentCard {
    let type: PaymentCardType
    let name: String
    let number: Int
    let balance: Double
    let credit: Double
}
