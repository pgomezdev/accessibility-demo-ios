//
//  AccessibilityIdentifier+Login.swift
//  AccessibilityDemo
//

extension AccessibilityIdentifier {
    enum Login: String, AccessibilityIdentifierGenerator, CaseIterable {
        case contentTitleLabel
        case contentMessageLabel
        case pinIndicator
    }
}
