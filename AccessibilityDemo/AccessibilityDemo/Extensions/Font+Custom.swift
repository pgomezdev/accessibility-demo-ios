//
//  Font+Custom.swift
//  AccessibilityDemo
//

import SwiftUI

extension Font {
    
    /**
     Creates a custom brand font for a specific `Font.TextStyle`, with optional fixed size or scalable size relative to the text style.
     
     - Parameters:
        - textStyle: The `Font.TextStyle` for which the custom font will be created.
        - fixedSize: A Boolean indicating whether the font size should remain fixed (`true`) or scale relative to the text style (`false`). Default is `false`.
     
     - Returns: A `Font` instance using the specified custom font, either with a fixed size or a size that scales dynamically based on the system's settings.
     
     ### Why Dynamic Type Matters:
        Dynamic Type is crucial for ensuring accessibility and user experience. By supporting dynamic scaling of text sizes, apps can accommodate users with varying visual abilities or preferences. When `fixedSize` is set to `false`, the font will respect the user's preferred text size as configured in their device settings, making the app more inclusive and usable.
     
     - Benefits of Dynamic Type:
        1. **Accessibility**: Improves readability for users with visual impairments.
        2. **Consistency**: Ensures that text sizes adapt uniformly across the app.
        3. **User Preference**: Respects user-configured font scaling, enhancing comfort and usability.
     
     If `fixedSize` is `true`, the font size remains constant regardless of user settings, which may be suitable for decorative or branding-specific text but should be used sparingly to avoid accessibility issues.
     
     ### Guide to Text Styles:
     
     - **`.largeTitle`:**
        A style for prominent titles, such as the main heading of a screen.
        Example: "Welcome to the App" on a home screen.
     
     - **`.title`:**
        A style for section titles or headers that are secondary to `.largeTitle`.
        Example: "Features" heading in a settings screen.
     
     - **`.title2`:**
        A style for subsections or smaller headers.
        Example: "Account Settings" under a larger section header.
     
     - **`.title3`:**
        A style for tertiary titles or smaller subsection headings.
        Example: "Notifications Settings" inside a section.
     
     - **`.headline`:**
        A style for highlighted or emphasized short text, such as labels or headings for smaller components.
        Example: A label above an input field.
     
     - **`.subheadline`:**
        A style for supporting text or metadata.
        Example: Timestamps or brief explanatory text under headlines.
     
     - **`.body`:**
        A style for standard, readable text for paragraphs or longer-form content.
        Example: The main content of an article or description.
     
     - **`.callout`:**
        A style for informative or featured text that is slightly more prominent than body text.
        Example: A callout for a key feature or promotional message.
     
     - **`.footnote`:**
        A style for supplementary or small informational text.
        Example: Legal disclaimers or footnotes at the bottom of the screen.
     
     - **`.caption`:**
        A style for descriptive text for images or UI elements.
        Example: A caption under an image in a gallery.
     
     - **`.caption2`:**
        A style for even smaller captions or accessory text.
        Example: Tiny labels for status icons or tooltips.
     */
    static func brandCustom(for textStyle: Font.TextStyle, fixedSize: Bool = false) -> Font {
        let useBoldText = UIAccessibility.isBoldTextEnabled
        
        let defaultFontSize = Font.preferredFontSize(for: textStyle)
        let defaultFontName = Font.defaultFontName(for: textStyle)
        
        let fontName: String
        let fontSize: CGFloat
        switch textStyle {
        case .largeTitle:
            fontName = "AvenirNext-Bold"
            fontSize = 34
        case .title:
            fontName = "AvenirNext-Bold"
            fontSize = 28
        case .title2:
            fontName = "AvenirNext-Bold"
            fontSize = 22
        case .title3:
            fontName = "AvenirNext-Bold"
            fontSize = 20
        case .headline:
            fontName = "AvenirNext-Bold"
            fontSize = 17
        case .subheadline:
            fontName = "AvenirNext-Bold"
            fontSize = 15
        case .body:
            fontName = useBoldText ? "AvenirNext-Bold" : "AvenirNext-Regular"
            fontSize = 17
        case .callout:
            fontName = useBoldText ? "AvenirNext-Bold" : "AvenirNext-Regular"
            fontSize = 16
        case .footnote:
            fontName = "AvenirNext-Regular"
            fontSize = 13
        case .caption:
            fontName = "AvenirNext-Italic"
            fontSize = 12
        case .caption2:
            fontName = "AvenirNext-Italic"
            fontSize = 11
        default:
            fontName = defaultFontName
            fontSize = defaultFontSize
        }
        
        if fixedSize {
            return .custom(fontName, fixedSize: fontSize)
        } else {
            return .custom(fontName, size: fontSize, relativeTo: textStyle)
        }
    }
    
    /**
     Retrieves the preferred font size for the given `Font.TextStyle`.
     
     - Parameter textStyle: The `Font.TextStyle` for which the size is needed.
     - Returns: The default font size for the specified text style.
     */
    static func preferredFontSize(for textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .body: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        @unknown default: return 17 // Fallback to `.body` size for unknown styles
        }
    }
    
    /**
     Retrieves the default font name for a given `Font.TextStyle`.
     
     - Parameter textStyle: The `Font.TextStyle` for which the font name is needed.
     - Returns: The name of the default system font for the specified text style.
     */
    static func defaultFontName(for textStyle: Font.TextStyle) -> String {
        // Map `Font.TextStyle` to `UIFont.TextStyle`
        let uiTextStyle: UIFont.TextStyle
        switch textStyle {
        case .largeTitle: uiTextStyle = .largeTitle
        case .title: uiTextStyle = .title1
        case .title2: uiTextStyle = .title2
        case .title3: uiTextStyle = .title3
        case .headline: uiTextStyle = .headline
        case .body: uiTextStyle = .body
        case .callout: uiTextStyle = .callout
        case .subheadline: uiTextStyle = .subheadline
        case .footnote: uiTextStyle = .footnote
        case .caption: uiTextStyle = .caption1
        case .caption2: uiTextStyle = .caption2
        @unknown default: uiTextStyle = .body
        }
        
        // Retrieve the default font name for the text style
        let defaultFont = UIFont.preferredFont(forTextStyle: uiTextStyle)
        return defaultFont.fontName
    }
}

#Preview("Text Styles") {
    ScrollView {
        VStack(spacing: 20) {
            Text("🎨 Text Style Guide")
                .font(.brandCustom(for: .largeTitle))
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)

            let textStyles: [(Font.TextStyle, String)] = [
                (.largeTitle, "The big boss of titles 🌟\nUse this for the main screen headline, like 'Welcome to Our App!'"),
                (.title, "Section headers that demand respect 📖\nPerfect for 'Features' or 'Settings' section titles."),
                (.title2, "Subsection leaders 🤓\nGreat for grouping content under a section, like 'Account Settings'."),
                (.title3, "Tertiary titles trying to stand out 🥉\nUse for smaller subsections, like 'Notifications'."),
                (.headline, "Short and bold statements 💡\nIdeal for button labels or top-of-card titles."),
                (.subheadline, "Supportive, yet noticeable 📋\nUse for subtitles, dates, or metadata below headlines."),
                (.body, "The meat and potatoes of your text 🍖\nGreat for articles, descriptions, or chat messages."),
                (.callout, "Attention grabbers 🗣️\nPerfect for tips, promotions, or feature highlights."),
                (.footnote, "Small but mighty 📜\nUse for disclaimers, legal text, or additional information."),
                (.caption, "Stylish and classy 🎨\nPerfect under an image or for detailed annotations."),
                (.caption2, "The tiniest details 🕵️‍♂️\nUse for minor captions, tooltips, or small labels.")
            ]

            ForEach(textStyles, id: \.0) { style, description in
                VStack(alignment: .leading) {
                    Text("Example of \(style):")
                        .font(.brandCustom(for: style))
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(description)
                        .font(.brandCustom(for: .footnote))
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 16)
            }
        }
        .padding(.top)
    }
}
