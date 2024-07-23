//
//  Stub.swift
//  AccessibilityDemo
//

import Foundation
import CoreLocation

/// This struct is used to replace all logic and keep the demo code simple, so the project can focus on accessibility.
struct Stub {
    
    static let accounts = [
        Account(name: "Payroll Account", number: 12345678901234, balance: 43_500.24),
        Account(name: "Current Account", number: 98765432109876, balance: 5_200.05)
    ]
    
    static let cards = [
        DebitCreditCard(type: .visa, name: "Classic", number: 1111222233334444, balance: 142.23, credit: 0),
        DebitCreditCard(type: .masterCard, name: "Premium", number: 5555666677778888, balance: 610, credit: 2_000)
    ]
    
    static let insurances = [
        Insurance(name: "General Home Insurance", value: 300_000),
        Insurance(name: "Holiday Home Insurance", value: 30_000),
        Insurance(name: "Life Insurance", value: 100_000)
    ]
    
    static let inboxItems = [
        InboxItem(id: UUID().uuidString, type: .information, message: "Your monthly statement is now available.", date: Date(timeIntervalSinceNow: -86400 * 1)), // 1 day ago
        InboxItem(id: UUID().uuidString, type: .warning, message: "Unusual login activity detected. Please verify your account.", date: Date(timeIntervalSinceNow: -86400 * 2)), // 2 days ago
        InboxItem(id: UUID().uuidString, type: .payment, message: "Your recent payment of $150 to ABC Utilities has been processed.", date: Date(timeIntervalSinceNow: -86400 * 3)), // 3 days ago
        InboxItem(id: UUID().uuidString, type: .warning, message: "Unauthorized access attempt detected.", date: Date(timeIntervalSinceNow: -86400 * 2)), // 2 days ago
        InboxItem(id: UUID().uuidString, type: .income, message: "Your salary of $3000 has been deposited.", date: Date(timeIntervalSinceNow: -86400 * 4)), // 4 days ago
        InboxItem(id: UUID().uuidString, type: .information, message: "New features added to our mobile banking app.", date: Date(timeIntervalSinceNow: -86400 * 5)), // 5 days ago
        InboxItem(id: UUID().uuidString, type: .warning, message: "Your account is overdrawn. Please deposit funds to avoid penalties.", date: Date(timeIntervalSinceNow: -86400 * 6)), // 6 days ago
        InboxItem(id: UUID().uuidString, type: .payment, message: "Your credit card payment of $200 is due tomorrow.", date: Date(timeIntervalSinceNow: -86400 * 7)), // 7 days ago
        InboxItem(id: UUID().uuidString, type: .income, message: "Refund of $50 has been credited to your account.", date: Date(timeIntervalSinceNow: -86400 * 8)), // 8 days ago
        InboxItem(id: UUID().uuidString, type: .warning, message: "Account balance below minimum threshold.", date: Date(timeIntervalSinceNow: -86400 * 10)), // 10 days ago
    ]
    
    static let pois = [
        POI(id: "1", type: .branch, name: "Downtown Branch", coordinate: CLLocationCoordinate2D(latitude: 37.4421, longitude: -122.1434)),
        POI(id: "2", type: .atm, name: "University ATM", coordinate: CLLocationCoordinate2D(latitude: 37.4283, longitude: -122.1697)),
        POI(id: "3", type: .foreignExchange, name: "Stanford Foreign Exchange", coordinate: CLLocationCoordinate2D(latitude: 37.4275, longitude: -122.1697)),
        POI(id: "4", type: .branch, name: "Midtown Branch", coordinate: CLLocationCoordinate2D(latitude: 37.4250, longitude: -122.1252)),
        POI(id: "5", type: .atm, name: "California Ave ATM", coordinate: CLLocationCoordinate2D(latitude: 37.4220, longitude: -122.1477)),
        POI(id: "6", type: .branch, name: "South Branch", coordinate: CLLocationCoordinate2D(latitude: 37.4000, longitude: -122.1350)),
        POI(id: "7", type: .atm, name: "Embarcadero ATM", coordinate: CLLocationCoordinate2D(latitude: 37.4490, longitude: -122.1270)),
        POI(id: "8", type: .foreignExchange, name: "Palo Alto Foreign Exchange", coordinate: CLLocationCoordinate2D(latitude: 37.4470, longitude: -122.1600)),
    ]
    
    static let budgets = [
        Budget(month: 1, amount: 1_100),
        Budget(month: 2, amount: 400),
        Budget(month: 3, amount: 3_300),
        Budget(month: 4, amount: 900),
        Budget(month: 5, amount: 2_300),
        Budget(month: 6, amount: 1_200)
    ]
}
