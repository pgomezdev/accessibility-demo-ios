//
//  InsuranceViewItem.swift
//  AccessibilityDemo
//

import SwiftUI

struct InsuranceViewItem: View {
    let insurance: Insurance
    
    var body: some View {
        HStack {
            Image(systemName: insurance.logoName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.mint)
                .frame(width: 50)
            
            Text(insurance.name)
                .font(.brandCustom(for: .body))
                .foregroundStyle(Color.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
            .padding()
            .background(Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(height: 100)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(insurance.name)
            .accessibilityHint("insurance.item.hint")
            .accessibilityInputLabels([insurance.name])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InsuranceViewItem(insurance: Insurance(name: "Life Insurance", value: 100_000, logoName: "house.fill"))
}
