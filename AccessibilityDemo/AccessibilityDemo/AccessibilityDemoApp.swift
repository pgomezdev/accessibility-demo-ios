//
//  AccessibilityDemoApp.swift
//  AccessibilityDemo
//

import SwiftUI

@main
struct AccessibilityDemoApp: App {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    @Environment(\.accessibilityInvertColors) var invertColors
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.accessibilityDimFlashingLights) var dimLights
    @Environment(\.accessibilityQuickActionsEnabled) var quickActionsEnabled
    @Environment(\.accessibilitySwitchControlEnabled) var switchControlEnabled
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    getAccessibilitySettings()
                }
        }
    }
    
    /**
     Collects accessibility settings and locale information.
     
     This method provides insight into the current accessibility settings and locale, which can be useful for understanding user needs
     and improve accessibility.
     */
    func getAccessibilitySettings() {
        print("colorScheme: \(colorScheme)")
        print("dynamicTypeSize: \(dynamicTypeSize)")
        print("invertColors: \(invertColors)")
        print("reduceMotion: \(reduceMotion)")
        print("reduceTransparency: \(reduceTransparency)")
        print("voiceOverEnabled: \(voiceOverEnabled)")
        print("dimLights: \(dimLights)")
        print("quickActionsEnabled: \(quickActionsEnabled)")
        print("switchControlEnabled: \(switchControlEnabled)")
        
        print("region: \(Locale.current.region?.identifier ?? "Unknown")")
        print("language: \(Locale.current.language.languageCode ?? "Unknown")")
    }
}
