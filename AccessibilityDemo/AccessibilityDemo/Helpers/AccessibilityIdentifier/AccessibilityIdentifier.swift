//
//  AccessibilityIdentifier.swift
//  AccessibilityDemo
//

import Foundation

protocol AccessibilityIdentifierGenerator {
    func build() -> String
}

extension AccessibilityIdentifierGenerator {
    func build() -> String {
        "\(String(describing: Self.self)).\(String(describing: self))"
    }
}

enum AccessibilityIdentifier {}
