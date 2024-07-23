//
//  DebitCreditCard.swift
//  AccessibilityDemo
//

import Foundation

enum DebitCreditCardType: String {
    case visa, masterCard
}

struct DebitCreditCard {
    let type: DebitCreditCardType
    let name: String
    let number: Int
    let balance: Double
    let credit: Double
}
