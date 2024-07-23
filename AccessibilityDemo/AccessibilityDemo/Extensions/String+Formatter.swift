//
//  String+Formatter.swift
//  AccessibilityDemo
//

import Foundation

extension String {
    
    static func localizedCurrency(from value: Double, maxDecimals: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxDecimals
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    static let maskedCharacters = "*****"
    
    func masked(_ mask: Bool) -> String {
        mask ? String.maskedCharacters : self
    }
    
    static func monthName(from monthNumber: Int) -> String? {
        guard monthNumber >= 1 && monthNumber <= 12 else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, month: monthNumber)
        
        if let date = calendar.date(from: dateComponents) {
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
