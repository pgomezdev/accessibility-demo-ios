# AccessibilityDemo

Welcome to the AccessibilityDemo project! This iOS SwiftUI app showcases how to implement various accessibility features using a fake bank app as an example. Below are the key features and components of the app.

## Features

### Localization
* Localizable File: Translations are set using a Localizable file to support multiple languages and enhance accessibility for non-English speaking users.

### Accessibility Statistics
* Accessibility Features Report: Important accessibility features are read at the beginning of the app. These features can be sent to a private server to collect accessibility statistics, which help improve the app's accessibility over time.

### Colors
* AppColor Class: Defines the colors used in the app, supporting system colors that automatically adapt to high contrast and dark modes. Custom colors have variations added for these modes.
* Cultural Color Variations: Some colors represent emotions and are set depending on different cultural contexts.

### Fonts
* AppFont Class: Defines the fonts used in the app and supports the boldTextEnabled setting for users who prefer bold text.

## Accessibility Enhancements

### Accessibility Features
* accessibilityLabel: Provides a concise label that succinctly identifies the accessibility element.
    * e.g. Used in the AccountThumb view.
* accessibilityHint: Offers additional context or guidance on what the element does.
    * e.g. Utilized in the AccountThumb view for buttons.
* accessibilityInputLabel: Specifies a label that describes the input expected by the element.
    * e.g. Implemented in the AccountThumb view for input fields.
* accessibilityAddTraits: Adds custom traits to the accessibility element to modify its behavior.
    * e.g. Showcased in the AccountThumb view.
* accessibilitySortPriority: Defines the priority for how elements are read by VoiceOver.
    * e.g. Used in the Inbox screen to reorder elements for VoiceOver.
* accessibilityRotorEntry: Allows custom rotors to navigate specific elements quickly.
    * e.g. Custom rotor entry for "Warnings" in the Inbox screen and for ATMs in the Map view.
* accessibilityChildren: Provides a collection of elements that are logically children of the current element.
    * e.g. Applied in the BudgetGraph class for graph elements.
* accessibilityElement: Specifies whether the view should be treated as a single accessibility element or a container.
    * e.g. Used in various views to control how VoiceOver navigates the elements.

### Custom Views and Controls
* DynamicStack: A custom view container that chooses between HStack and VStack, useful for fitting large content on the screen. It is used in the headers of the HomeView.
* Editing Messages: The list of inbox messages can be edited. Users can slide to delete messages or use an alternative button if they cannot perform the slide movement.

## Animation Control
* Accessibility Reduce Motion: Data loading animations are disabled if the "Accessibility Reduce Motion" setting is enabled.
* Dim Flashing Lights: While not utilized in this demo project, could reduce or alter flashing light effects that may be problematic for some users.
* Reduce Transparency: Also not featured in this demo, but could minimize transparency effects to enhance visibility and clarity for some users.

## How to Use
1. Localization: Ensure that your device language is supported by checking the Localizable file.
2. VoiceOver: Enable VoiceOver to experience the custom accessibility labels, hints, and traits.
3. High Contrast and Dark Mode: Toggle these settings on your device to see the automatic color adjustments.
4. Bold Text: Enable the bold text setting to see the changes in the app's fonts.
5. Accessibility Reduce Motion: Enable the "Accessibility Reduce Motion" setting to disable data loading animations.
6. Custom Rotors: Use custom rotors to navigate through specific content like warnings in the inbox or ATMs on the map view.

While there are many more accessibility features available, this project focuses on the basics. I hope this demo app helps you understand and incorporate accessibility features into your own projects. Your feedback is valuable, so let me know which other features do you think are important to make apps more accessible for everyone.

## Contact

For questions, feedback, or contributions, please reach out to me at [pgomez.ping@gmail.com].
