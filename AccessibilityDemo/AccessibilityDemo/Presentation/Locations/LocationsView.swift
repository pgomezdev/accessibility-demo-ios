//
//  LocationsView.swift
//  AccessibilityDemo
//

import SwiftUI
import CoreLocation
import MapKit

struct LocationsView: View {
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @ScaledMetric var navBarImageSize: CGFloat = 30
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.4419, longitude: -122.1430),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State var searchText = ""
    @State var pois: [POI] = []
    @State var showList = false
    
    @Namespace private var poiRotorNamespace
    
    var body: some View {
        NavigationStack {
            Group {
                if showList {
                    List(pois) { poi in
                        VStack(alignment: .leading) {
                            Text(poi.name)
                                .font(.headline)
                            
                            Text(poi.type.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    Map {
                        ForEach(pois) { poi in
                            Marker(coordinate: poi.coordinate) {
                                Image(systemName: annotationImage(for: poi.type))
                                    .accessibilityRotorEntry(id: poi.id, in: poiRotorNamespace)
                            }
                            .tint(annotationColor(for: poi.type))
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    .accessibilityElement(children: .contain)
                    .accessibilityRotor(Text("locations.map.accessibilityRotor")) {
                        ForEach(pois.filter({$0.type == .atm})) { poi in
                            AccessibilityRotorEntry(Text(poi.name), id: poi.id, in: poiRotorNamespace)
                        }
                    }
                }
            }
            .navigationTitle("locations.title")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "locations.search.prompt")
            .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showList.toggle() }, label: {
                        Image(systemName: showList ? "map" : "list.bullet")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: navBarImageSize, height: navBarImageSize)
                    })
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.hideValuesButton.build())
                    .accessibilityLabel(showList ? "locations.showList.button.accessibilityLabel.hide" : "locations.showList.button.accessibilityLabel.show")
                    .accessibilityHint(showList ? "locations.showList.button.accessibilityHint.hide" : "locations.showList.button.accessibilityHint.show")
                    .accessibilityInputLabels(showList ? ["locations.showList.button.accessibilityInputLabel.hide"] : ["locations.showList.button.accessibilityInputLabel.show"])
                }
            }
        }
        .onAppear {
            if voiceOverEnabled {
                showList = true
            }
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
