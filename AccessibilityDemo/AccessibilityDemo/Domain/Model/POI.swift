//
//  POI.swift
//  AccessibilityDemo
//

import Foundation
import CoreLocation

enum POIType {
    case branch, atm, foreignExchange
    
    var description: String {
        switch self {
        case .branch: return NSLocalizedString("poi.type.branch", comment: "POI branch type")
        case .atm: return NSLocalizedString("poi.type.atm", comment: "POI ATM type")
        case .foreignExchange: return NSLocalizedString("poi.type.foreignExchange", comment: "POI foreign exchange type")
        }
    }
}

struct POI: Identifiable {
    let id: String
    let type: POIType
    let name: String
    let coordinate: CLLocationCoordinate2D
}
