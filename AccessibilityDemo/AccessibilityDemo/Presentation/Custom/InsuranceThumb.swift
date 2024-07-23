//
//  InsuranceThumb.swift
//  AccessibilityDemo
//

import SwiftUI

struct InsuranceThumb: View {
    let insurance: Insurance
    
    var body: some View {
        Text(insurance.name)
            .font(AppFont.body1)
            .foregroundStyle(AppColor.onSurface)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(AppColor.surface)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(insurance.name)
            .accessibilityHint("Opens this insurance details")
            .accessibilityInputLabels([insurance.name])
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        InsuranceThumb(insurance: Insurance(name: "Life Insurance", value: 100_000))
    }
}
