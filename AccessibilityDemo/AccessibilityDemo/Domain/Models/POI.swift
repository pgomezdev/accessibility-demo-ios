//
//  POI.swift
//  AccessibilityDemo
//

import Foundation
import CoreLocation

enum POIType {
    case branch, atm, foreignExchange
}

struct POI: Identifiable {
    let id: String
    let type: POIType
    let name: String
    let coordinate: CLLocationCoordinate2D
}
