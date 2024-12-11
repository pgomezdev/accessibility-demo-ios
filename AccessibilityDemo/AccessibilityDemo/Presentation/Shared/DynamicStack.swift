//
//  DynamicStack.swift
//  AccessibilityDemo
//

import SwiftUI

/**
 A flexible stack view that adapts its orientation (vertical or horizontal) based on a specified configuration.
 
 `DynamicStack` organizes child views in either a `VStack` or an `HStack`, depending on the `orientation` parameter.
 It's ideal for creating adaptive layouts that adjust to screen size or device orientation.
 
 ### Example:
 ```swift
 DynamicStack(orientation: .horizontal) {
    Text("Hello")
    Text("World")
 }
 ```
 
 ### Adaptive Layout:
 Combine `DynamicStack` with environment values or screen size:
 ```swift
 @Environment(\.dynamicTypeSize) var typeSize
 DynamicStack(orientation: typeSize.isAccessibilitySize ? .horizontal : .vertical) {
    Text("Responsive")
    Text("Layout")
 }
 ```
 
 - Parameters:
    - orientation: The stack's layout direction (`.vertical` or `.horizontal`).
    - horizontalAlignment: Alignment for `.vertical` orientation.
    - verticalAlignment: Alignment for `.horizontal` orientation.
    - content: A closure that defines the child views.
 */
struct DynamicStack<Content: View>: View {
    enum Orientation {
        case vertical, horizontal
    }
    
    let orientation: Orientation
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let content: () -> Content
    
    init(orientation: Orientation, horizontalAlignment: HorizontalAlignment = .center, verticalAlignment: VerticalAlignment = .center, @ViewBuilder content: @escaping () -> Content) {
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.content = content
    }
    
    var body: some View {
        if orientation == .vertical {
            VStack(alignment: horizontalAlignment) {
                content()
            }
        } else {
            HStack(alignment: verticalAlignment) {
                content()
            }
        }
    }
}
