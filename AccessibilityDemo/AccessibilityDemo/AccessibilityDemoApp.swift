//
//  AccessibilityDemoApp.swift
//  AccessibilityDemo
//

import SwiftUI

@main
struct AccessibilityDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) var scenePhase
    
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
                .onChange(of: scenePhase) { _, newPhase in
                    switch newPhase {
                    case .background:
                        addQuickActions()
                    case .inactive:
                        break
                    case .active:
                        break
                    @unknown default:
                        break
                    }
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
    
    func addQuickActions() {
        let newNoteAction = UIApplicationShortcutItem(
            type: "com.demo.AccessibilityDemo.newTransfer",
            localizedTitle: NSLocalizedString("quickaction.newTransfer.title", comment: "Title for new transfer quick action"),
            localizedSubtitle: nil,
            icon: UIApplicationShortcutIcon(type: .compose)
        )
        
        let searchAction = UIApplicationShortcutItem(
            type: "com.demo.AccessibilityDemo.searchATM",
            localizedTitle: NSLocalizedString("quickaction.searchATMs.title", comment: "Title for search ATMs quick action"),
            localizedSubtitle: nil,
            icon: UIApplicationShortcutIcon(type: .search)
        )
        
        UIApplication.shared.shortcutItems = [newNoteAction, searchAction]
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem {
            QuickActionsManager.shared.handleQaItem(shortcutItem)
        }
        
        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        
        return sceneConfiguration
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(true)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        QuickActionsManager.shared.handleQaItem(shortcutItem)
    }
}

class QuickActionsManager: ObservableObject {
    
    static let shared = QuickActionsManager()

    func handleQaItem(_ shortcutItem: UIApplicationShortcutItem) {
        // TODO: Observe these notifications and trigger actions
        switch shortcutItem.type {
        case "com.demo.AccessibilityDemo.newTransfer":
            NotificationCenter.default.post(name: .newTransferQuickAction, object: nil)
        case "com.demo.AccessibilityDemo.searchATM":
            NotificationCenter.default.post(name: .searchATMsQuickAction, object: nil)
        default:
            break
        }
    }
}
