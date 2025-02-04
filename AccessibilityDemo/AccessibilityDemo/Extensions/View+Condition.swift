//
//  View+Condition.swift
//  AccessibilityDemo
//


import SwiftUI

extension View {
    
    /**
     Applies the given transform if the given condition evaluates to `true`.

     ```
     .if(true) { view in
         view.background(Color.black)
     } // Sets the view's background to black
     ```
     
     - Parameters:
        - condition: The condition to evaluate.
        - transform: The transform to apply to the source `View`.
     - Returns: Either the original `View` or the modified `View` if the condition is `true`.
     */
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
