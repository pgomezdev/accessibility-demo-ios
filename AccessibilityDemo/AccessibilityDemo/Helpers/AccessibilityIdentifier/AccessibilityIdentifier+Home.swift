//
//  AccessibilityIdentifier+Home.swift
//  AccessibilityDemo
//

import Foundation

extension AccessibilityIdentifier {
    enum Home: String, AccessibilityIdentifierGenerator, CaseIterable {
        case hideValuesButton
        case accountsLabel
        case totalAccountsBalanceLabel
        case accountItem
        case cardsLabel
        case totalCardsBalanceLabel
        case cardItem
        case insurancesLabel
        case insuranceItem
        case budgetHistoryLabel
    }
}
