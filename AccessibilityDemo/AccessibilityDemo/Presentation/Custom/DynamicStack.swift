//
//  DynamicStack.swift
//  AccessibilityDemo
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    enum Orientation {
        case vertical, horizontal
    }
    
    let orientation: Orientation
    let content: () -> Content
    
    init(orientation: Orientation, @ViewBuilder content: @escaping () -> Content) {
        self.orientation = orientation
        self.content = content
    }
    
    var body: some View {
        if orientation == .vertical {
            VStack {
                content()
            }
        } else {
            HStack {
                content()
            }
        }
    }
}
