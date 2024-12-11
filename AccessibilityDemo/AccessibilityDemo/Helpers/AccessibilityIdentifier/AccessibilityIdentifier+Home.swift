//
//  AccessibilityIdentifier+Home.swift
//  AccessibilityDemo
//

import Foundation

extension AccessibilityIdentifier {
    enum Home: String, AccessibilityIdentifierGenerator, CaseIterable {
        case hideValuesButton
        case accountsTitle
        case totalAccountsBalanceLabel
        case accountCardItem
        case cardsTitle
        case totalCardsBalanceLabel
        case cardItem
        case insurancesTitle
        case insuranceItem
        case budgetHistoryTitle
    }
}
