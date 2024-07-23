//
//  RootView.swift
//  AccessibilityDemo
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.homeButton.build())
            
            InboxView()
                .tabItem {
                    Label("Inbox", systemImage: "tray")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.inboxButton.build())
            
            LocationsView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.mapButton.build())
        }
    }
}

#Preview {
    RootView()
}
