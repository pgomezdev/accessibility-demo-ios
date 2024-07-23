//
//  String+Localizable.swift
//  AccessibilityDemo
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
    
    func localizedWithArguments(_ arguments: CVarArg...) -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return String(format: localizedString, arguments)
    }
}
