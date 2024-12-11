//
//  LocationsView.swift
//  AccessibilityDemo
//

import SwiftUI
import CoreLocation
import MapKit

struct LocationsView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.4419, longitude: -122.1430),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State var pois: [POI] = []
    
    @Namespace private var poiRotorNamespace
    
    var body: some View {
        Map {
            ForEach(pois) { poi in
                Marker(coordinate: poi.coordinate) {
                    Image(systemName: annotationImage(for: poi.type))
                        .accessibilityRotorEntry(id: poi.id, in: poiRotorNamespace)
                }
                .tint(annotationColor(for: poi.type))
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityRotor(Text("locations.map.accessibilityRotor")) {
            ForEach(pois.filter({$0.type == .atm})) { poi in
                AccessibilityRotorEntry(Text(poi.name), id: poi.id, in: poiRotorNamespace)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        pois = StubData.pois
    }
    
    private func annotationImage(for type: POIType) -> String {
        switch type {
        case .branch:
            return "building.2"
        case .atm:
            return "banknote"
        case .foreignExchange:
            return "dollarsign.circle"
        }
    }
    
    private func annotationColor(for type: POIType) -> Color {
        switch type {
        case .branch:
            return .blue
        case .atm:
            return .green
        case .foreignExchange:
            return .orange
        }
    }
}

#Preview {
    LocationsView()
}
