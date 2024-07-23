//
//  DebitCreditCardThumb.swift
//  AccessibilityDemo
//
//  Created by Pablo Gómez on 4/6/24.
//

import SwiftUI

struct DebitCreditCardThumb: View {
    @Environment(\.dynamicTypeSize) var typeSize
    
    let card: DebitCreditCard
    let hideValue: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(card.type == .visa ? "Visa" : "MasterCard")
                .resizable()
                .frame(
                    width: UIFontMetrics.default.scaledValue(for: 35),
                    height: UIFontMetrics.default.scaledValue(for: 35))
                .accessibilityIgnoresInvertColors()
            
            HStack {
                Text(card.name)
                    .font(AppFont.body2)
                    .foregroundStyle(AppColor.onSurface)
                
                Spacer()
                
                Text("*" + String(card.number).suffix(4))
                    .font(AppFont.body2)
                    .foregroundStyle(AppColor.onSurface)
            }
            .padding(.bottom)
            
            if (card.credit != 0) {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: geometry.size.width * (card.balance/card.credit))
                            .foregroundStyle(AppColor.primary)
                        
                        Rectangle()
                            .frame(width: geometry.size.width * (1 - card.balance/card.credit))
                            .foregroundStyle(AppColor.primary.opacity(0.5))
                    }
                }
                .frame(height: 8)
            } else {
                HStack{}.frame(height: 8)
            }
            
            HStack {
                Text(String.localizedCurrency(from: card.balance).masked(hideValue))
                    .font(AppFont.title3)
                    .foregroundStyle(AppColor.onSurface)
                
                Spacer()
                
                if (card.credit != 0) {
                    Text(String.localizedCurrency(from: card.credit).masked(hideValue))
                        .font(AppFont.title3)
                        .foregroundStyle(AppColor.onSurface)
                        .padding(.leading)
                }
            }
        }
        .padding()
        .background(AppColor.surface)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("Opens this card's movements")
        .accessibilityInputLabels([card.name])
    }
    
    private var cardSuffix: String {
        "\(String(card.number).suffix(4))"
    }
    
    private var accessibilityLabel: Text {
        let baseLabel = Text("\(card.type.rawValue), \(card.name), ending in \(cardSuffix)", comment: "Refering to a debit/credit card")
        if (hideValue) {
            return baseLabel
        } else {
            let balanceLabel = Text(", balance \(String.localizedCurrency(from: card.balance))")
            if (card.credit == 0) {
                return baseLabel + balanceLabel
            } else {
                return baseLabel + balanceLabel + Text(", credit \(String.localizedCurrency(from: card.credit))")
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            DebitCreditCardThumb(
                card: DebitCreditCard(type: .visa, name: "Classic", number: 1111222233334444, balance: 324.54, credit: 0),
                hideValue: false
            )
            
            DebitCreditCardThumb(
                card: DebitCreditCard(type: .masterCard, name: "Premium", number: 5555666677778888, balance: 324.54, credit: 2_000),
                hideValue: false
            )
        }
    }
}

