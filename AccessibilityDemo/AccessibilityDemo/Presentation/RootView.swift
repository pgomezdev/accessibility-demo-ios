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
                    Label("root.tab.home", systemImage: "house")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.homeButton.build())
            
            InboxView()
                .tabItem {
                    Label("root.tab.inbox", systemImage: "tray")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.inboxButton.build())
            
            LocationsView()
                .tabItem {
                    Label("root.tab.map", systemImage: "map")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.Root.mapButton.build())
        }
    }
}

#Preview {
    RootView()
}
