//
//  AccessibilityIdentifier+Root.swift
//  AccessibilityDemo
//

import Foundation

extension AccessibilityIdentifier {
    enum Root: String, AccessibilityIdentifierGenerator, CaseIterable {
        case homeButton
        case inboxButton
        case mapButton
    }
}
