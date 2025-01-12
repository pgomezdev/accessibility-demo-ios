//
//  PrivacyView.swift
//  AccessibilityDemo
//

import SwiftUI

struct PrivacyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        ZStack {
            if reduceTransparency {
                Color.background.ignoresSafeArea()
            } else {
                Image("PrivacyBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
            
            ScrollView {
                VStack {
                    Text("privacy.content")
                        .font(.brandCustom(for: .body))
                        .foregroundStyle(Color.onBackground)
                }
                .padding()
            }
            .if(!reduceTransparency, transform: { view in
                view.background(.ultraThinMaterial)
            })
        }
        .navigationTitle("privacy.title")
    }
}

#Preview {
    NavigationView {
        PrivacyView()
    }
}
