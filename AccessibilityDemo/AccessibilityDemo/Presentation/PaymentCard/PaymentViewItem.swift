//
//  PaymentViewItem.swift
//  AccessibilityDemo
//
//  Created by Pablo Gómez on 4/6/24.
//

import SwiftUI

struct PaymentViewItem: View {
    let card: PaymentCard
    let hideValue: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(card.type == .visa ? "Visa" : "MasterCard")
                .resizable()
                .scaledToFit()
                .frame(width: UIFontMetrics.default.scaledValue(for: 35))
                .accessibilityIgnoresInvertColors()
            
            HStack {
                Text(card.name)
                    .font(.brandCustom(for: .subheadline))
                    .foregroundStyle(Color.onSurface)
                
                Spacer()
                
                Text(cardSuffix)
                    .font(.brandCustom(for: .subheadline))
                    .foregroundStyle(Color.onSurface)
            }
            .padding(.bottom)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    if (card.credit != 0) {
                        Rectangle()
                            .fill(Color.customNegative)
                            .frame(width: geometry.size.width * (card.balance/card.credit))
                        
                        Rectangle()
                            .fill(Color.customPositive)
                            .frame(width: geometry.size.width * (1 - card.balance/card.credit))
                    }
                }
                .accessibilityHidden(true)
            }
            .frame(height: 8)
            
            HStack {
                Text(cardBalance)
                    .font(.brandCustom(for: .title3))
                    .foregroundStyle(Color.onSurface)
                
                Spacer()
                
                if (card.credit != 0) {
                    Text(cardCredit)
                        .font(.brandCustom(for: .title3))
                        .foregroundStyle(Color.onSurface)
                        .padding(.leading)
                }
            }
        }
        .padding()
        .background(Color.surface)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("payment.item.hint")
        .accessibilityInputLabels([card.name])
    }
    
    var cardSuffix: String {
        "*\(String(card.number).suffix(4))"
    }
    
    var cardBalance: String {
        let balance = String.localizedCurrency(from: card.balance)
        return hideValue ? balance.masked() : balance
    }
    
    var cardCredit: String {
        let credit = String.localizedCurrency(from: card.credit)
        return hideValue ? credit.masked() : credit
    }
    
    var accessibilityLabel: Text {
        let description = Text(
            String.localizedStringWithFormat(
                NSLocalizedString("payment.item.accessibilityLabel.description", comment: "Payment card description"),
                card.type.rawValue,
                card.name,
                cardSuffix
            )
        )
        let balance = Text(
            String.localizedStringWithFormat(
                NSLocalizedString("payment.item.accessibilityLabel.balance", comment: "Payment card balance description"),
                String.localizedCurrency(from: card.balance)
            )
        )
        let credit = Text(
            String.localizedStringWithFormat(
                NSLocalizedString("payment.item.accessibilityLabel.credit", comment: "Payment card credit description"),
                String.localizedCurrency(from: card.credit)
            )
        )
        return hideValue ? description : description + balance + (card.credit == 0 ? Text(verbatim: "") : credit)
    }
}

#Preview("Debit", traits: .sizeThatFitsLayout) {
    PaymentViewItem(
        card: PaymentCard(type: .visa, name: "Classic", number: 1111222233334444, balance: 324.54, credit: 0),
        hideValue: false
    )
}

#Preview("Credit", traits: .sizeThatFitsLayout) {
    PaymentViewItem(
        card: PaymentCard(type: .masterCard, name: "Premium", number: 5555666677778888, balance: 324.54, credit: 2_000),
        hideValue: false
    )
}

