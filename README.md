# AccessibilityDemo

This repository contains a simple example banking app created with SwiftUI to showcase accessibility best practices in iOS development. The app demonstrates how to make user interfaces inclusive and accessible to a wide range of users, including those with vision or mobility impairments.

# Purpose

The purpose of this project is to illustrate how to implement and integrate various accessibility features in an iOS app using SwiftUI. By adhering to accessibility guidelines, we ensure that everyone can have an equitable and pleasant user experience.

# Accessibility Features

## Vision

This section focuses on users with visual impairments. The app supports features such as VoiceOver, Dynamic Type, and others to ensure clarity and usability.

### VoiceOver Support

* accessibilityLabel: Provides a concise label that succinctly identifies the accessibility element.
* accessibilityHint: Offers additional context or guidance on what the element does.
* accessibilityAddTraits: Adds custom traits to the accessibility element to modify its behavior.
* accessibilityElement: Specifies whether the view should be treated as a single accessibility element or a container.
    * See account items in HomeView at [AccountViewItem.swift (lines 30-34)](AccessibilityDemo/AccessibilityDemo/Presentation/Account/AccountViewItem.swift#L30-L34)
* accessibilitySortPriority: Defines the priority for how elements are read by VoiceOver.
   * See inbox items in InboxView at [InboxView.swift (line 31)](AccessibilityDemo/AccessibilityDemo/Presentation/Inbox/InboxView.swift#L31)
* accessibilityRotorEntry: Allows custom rotors to navigate specific elements quickly.
   * See warning inbox items in InboxView at [InboxView.swift (lines 81-89)](AccessibilityDemo/AccessibilityDemo/Presentation/Inbox/InboxView.swift#L81-L89)
* accessibilityChildren: Provides a collection of elements that are logically children of the current element.

### DynamicType Support

* DynamicStack: A custom view container that chooses between HStack and VStack, useful for fitting large content on the screen.
   * See the section titles and values in HomeView at [HomeView.swift (line 86)](AccessibilityDemo/AccessibilityDemo/Presentation/Inbox/InboxView.swift#L81-L89)
 
* Font+Custom extension: Creates a custom brand font relative to a default style supporting the boldTextEnabled setting for users who prefer bold text. [Font+Custom.swift)](AccessibilityDemo/AccessibilityDemo/Extensions/Font+Custom.swift)

### Other vision settings

* Dark mode and high contrast are supported by using default system colors, which automatically adapt to these settings.
* ReduceMotion is used to disable animations at [AboutView.swift](AccessibilityDemo/AccessibilityDemo/Presentation/About/AboutView.swift)
* ReduceTransparency is used to hide blurry images at [PrivacyView.swift](AccessibilityDemo/AccessibilityDemo/Presentation/Privacy/PrivacyView.swift)

## Mobility

This section addresses users with limited mobility. The app supports Voice Control and Switch Control for hands-free navigation and interaction.

### VoiceControl and SwitchControl Support

* accessibilityInputLabel: Specifies a label that describes the input expected by the element.
   * See menu button in HomeView at [HomeView.swift (line 31)](AccessibilityDemo/AccessibilityDemo/Presentation/Home/HomeView.swift#L55)

* Alternative design for inbox messages edition: The list of inbox messages can be edited. Users can slide to delete messages or use an alternative button if they cannot perform the slide movement. This is specially useful when using VoiceControl and SwitchControl. [InboxView.swift (line 31)](AccessibilityDemo/AccessibilityDemo/Presentation/Inbox/InboxView.swift)

## Inclusive design

### Localization
* Localizable File: Translations are set using a Localizable file to support multiple languages and enhance accessibility for non-English speaking users.

### Colors
* Cultural Color Variations: Some colors represent emotions and are set depending on different cultural contexts. [Color+Custom.swift](AccessibilityDemo/AccessibilityDemo/Extensions/Color+Custom.swift)

## Accessibility Statistics
* Accessibility Features Report: Important accessibility features are read at the beginning of the app. These features can be sent to a private server to collect accessibility statistics, which help improve the app's accessibility over time.

By implementing these features, this app serves as a template for creating inclusive and user-friendly iOS applications.

# Contact

For questions, feedback, or contributions, please reach out to me at [pgomez.ping@gmail.com].
