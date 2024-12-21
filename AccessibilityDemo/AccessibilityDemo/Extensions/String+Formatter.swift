//
//  String+Formatter.swift
//  AccessibilityDemo
//

import Foundation

extension String {
    
    // MARK: - Currency
    
    static func localizedCurrency(from value: Double, maxDecimals: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxDecimals
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    // MARK: - Date
    
    static func monthName(from monthNumber: Int, short: Bool = false) -> String? {
        guard monthNumber >= 1 && monthNumber <= 12 else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = short ? "MMM" : "MMMM"
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, month: monthNumber)
        
        if let date = calendar.date(from: dateComponents) {
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    // MARK: - Custom
    
    func masked(_ mask: Character = "*") -> String {
        String(repeating: mask, count: self.count)
    }
}
