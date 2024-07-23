//
//  AccessibilityIdentifier+Inbox.swift
//  AccessibilityDemo
//

import Foundation

extension AccessibilityIdentifier {
    enum Inbox: String, AccessibilityIdentifierGenerator, CaseIterable {
        case editButton
        case inboxItem
    }
}
