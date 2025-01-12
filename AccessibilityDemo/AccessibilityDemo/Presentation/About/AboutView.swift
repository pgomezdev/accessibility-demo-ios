//
//  AboutView.swift
//  AccessibilityDemo
//

import SwiftUI

struct AboutView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State private var itemOffset: CGFloat = UIScreen.main.bounds.width
    
    let items = [
        NSLocalizedString("about.item1.title", comment: ""),
        NSLocalizedString("about.item2.title", comment: ""),
        NSLocalizedString("about.item3.title", comment: ""),
        NSLocalizedString("about.item4.title", comment: ""),
        NSLocalizedString("about.item5.title", comment: ""),
        NSLocalizedString("about.item6.title", comment: ""),
        NSLocalizedString("about.item7.title", comment: ""),
        NSLocalizedString("about.item8.title", comment: "")
    ]
    
    let colors = [Color.main, Color.mint, Color.supplementary]
    
    var body: some View {
        VStack {
            ForEach(Array(items.enumerated()), id: \.offset) { index, element in
                Text(element)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule().fill(colors[index % colors.count])
                    )
                    .offset(x: itemOffset * (index % 2 == 0 ? 1 : -1))
                    .if(!reduceMotion, transform: { view in
                        view.animation(.bouncy(duration: 1, extraBounce: 0.2), value: itemOffset)
                    })
                    .onAppear {
                        itemOffset = 0
                    }
            }
            Spacer()
        }
        .padding()
        .background(Color.background)
        .navigationTitle("about.title")
    }
}

#Preview {
    NavigationView {
        AboutView()
    }
}
