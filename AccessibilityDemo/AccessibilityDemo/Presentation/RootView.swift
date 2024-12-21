//
//  RootView.swift
//  AccessibilityDemo
//

import SwiftUI

struct RootView: View {
    @State var loggedIn = false
    
    var body: some View {
        if loggedIn {
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
        } else {
            LoginView {
                loggedIn = true
            }
        }
    }
}

#Preview {
    RootView()
}
