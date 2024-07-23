//
//  AccountThumb.swift
//  AccessibilityDemo
//

import SwiftUI

struct AccountThumb: View {
    let account: Account
    let hideValue: Bool
    
    var body: some View {
        VStack {
            Text(account.name)
                .font(AppFont.body1)
                .foregroundStyle(AppColor.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("*" + String(account.number).suffix(4))
                .font(AppFont.body2)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            Text(String.localizedCurrency(from: account.balance).masked(hideValue))
                .font(AppFont.title3)
                .foregroundStyle(AppColor.onSurface)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(AppColor.surface)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("Opens this account's movements")
        .accessibilityInputLabels([account.name])
    }
    
    private var accountSuffix: String {
        "\(String(account.number).suffix(4))"
    }
    
    private var accessibilityLabel: Text {
        let baseLabel = Text("\(account.name), ending in \(accountSuffix)", comment: "Refering to a bank account")
        return hideValue ? baseLabel : baseLabel + Text(", balance \(String.localizedCurrency(from: account.balance))")
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        AccountThumb(
            account: Account(name: "Current account", number: 12345678901234, balance: 10_000.55),
            hideValue: false
        )
    }
}
