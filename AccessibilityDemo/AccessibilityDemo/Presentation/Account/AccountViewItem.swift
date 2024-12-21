//
//  AccountViewItem.swift
//  AccessibilityDemo
//

import SwiftUI

struct AccountViewItem: View {
    let account: Account
    let hideValue: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(account.name)
                .font(.brandCustom(for: .body))
            
            Text(accountSuffix)
                .font(.brandCustom(for: .subheadline))
            
            Text(accountBalance)
                .font(.brandCustom(for: .title3))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color.onSupplementary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("account.item.hint")
        .accessibilityInputLabels([account.name])
    }
    
    var accountBalance: String {
        let balance = String.localizedCurrency(from: account.balance)
        return hideValue ? balance.masked() : balance
    }
    
    var accountSuffix: String {
        "*\(String(account.number).suffix(4))"
    }
    
    var accessibilityLabel: Text {
        let description = Text(
            String.localizedStringWithFormat(
                NSLocalizedString("account.item.accessibilityLabel.description", comment: "Account name and number description"),
                account.name,
                accountSuffix
            )
        )
        let balance = Text(
            String.localizedStringWithFormat(
                NSLocalizedString("account.item.accessibilityLabel.balance", comment: "Account balance description"),
                String.localizedCurrency(from: account.balance)
            )
        )
        return hideValue ? description : description + balance
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AccountViewItem(
        account: Account(name: "Current account", number: 12345678901234, balance: 10_000.55),
        hideValue: false
    )
}
