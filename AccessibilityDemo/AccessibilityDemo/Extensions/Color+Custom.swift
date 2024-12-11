//
//  Color+Custom.swift
//  AccessibilityDemo
//

import SwiftUI

extension Color {
    
    /**
     A static variable that returns a "negative" color based on the user's region.
     
     - The color is determined by cultural perceptions of the 'red' color in different regions.
     - In many Western cultures, red is associated with negativity, danger, or error, making it a natural choice for a "negative" color.
     - In some Eastern cultures (e.g., China, India, Korea, Vietnam, Nigeria), red represents positivity, celebration, or success, and orange may be more appropriate for negative contexts.

     ### Why Cultural Perceptions Matter:
     - Colors have significant cultural meanings that vary across regions, often rooted in history, religion, and societal norms.
     - Ignoring cultural differences in color symbolism can lead to user confusion, misinterpretation, or even offense.
     - Designing with cultural awareness improves accessibility, inclusivity, and user trust, making your app feel relevant and respectful in different regions.

     */
    static var customNegative: Color {
        return switch Locale.current.region?.identifier {
        case "CN", "IN", "KR", "VN", "NG":
            Color.orange // Orange for a softer, less celebratory negative color
        default:
            Color.red // Red for danger or negativity in Western contexts
        }
    }
    
    /**
     A static variable that returns a "positive" color based on the user's region.
     
     - The color is determined by cultural perceptions of the 'red' color in different regions.
     - In Western cultures, green is commonly associated with success, growth, or positivity.
     - In many Eastern cultures, red is the color of celebration, prosperity, and positivity, making it a better choice for a "positive" color.

     ### Why Cultural Perceptions Matter:
     - Associating red with positivity in some cultures while using green in others ensures your app resonates with diverse audiences.
     - Colors are not universally understood the same way. Misalignment with cultural norms can lead to users feeling disconnected from the app's intent.
     - Thoughtful use of culturally aligned colors enhances the emotional impact and clarity of your app's messages.

     */
    static var customPositive: Color {
        switch Locale.current.region?.identifier {
        case "CN", "IN", "KR", "VN", "NG":
            Color.red // Red for celebration, prosperity, and positivity
        default:
            Color.green // Green for success and growth in Western cultures
        }
    }
    
    /**
     A static variable that returns a "warning" color.

     - Yellow is commonly used as a universal warning color.
     - It is generally understood as a color of caution across most cultures, making it a safe choice for warnings.

     ### Why Consistency Matters:
     - While some colors have varied meanings across cultures, others (like yellow for warnings) are more universally recognized.
     - Using consistent warning colors like yellow helps users quickly understand and respond to cautionary messages without cultural ambiguity.
     */
    static let customWarning: Color = Color.yellow
}

