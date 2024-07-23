//
//  HomeView.swift
//  AccessibilityDemo
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dynamicTypeSize) var typeSize
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State var isHidingValues = false
    @State var accounts: [Account] = []
    @State var cards: [DebitCreditCard] = []
    @State var insurances: [Insurance] = []
    @State var budgets: [Budget] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        DynamicStack(orientation: isLargeTypeSize ? .vertical : .horizontal) {
                            Text("Accounts")
                                .font(AppFont.headline)
                                .foregroundStyle(AppColor.onBackground)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityIdentifier(AccessibilityIdentifier.Home.accountsLabel.build())
                                .accessibilityAddTraits(.isHeader)
                                
                            Spacer()
                            
                            Text(String.localizedCurrency(from: accounts.map{$0.balance}.reduce(0, +)).masked(isHidingValues))
                                .font(AppFont.body1)
                                .foregroundStyle(AppColor.onBackground)
                                .frame(maxWidth: .infinity, alignment: isLargeTypeSize ? .leading : .trailing)
                                .accessibilityIdentifier(AccessibilityIdentifier.Home.totalAccountsBalanceLabel.build())
                                .accessibilityLabel("Total balance, \(String.localizedCurrency(from: accounts.map{$0.balance}.reduce(0, +)))")
                        }
                        .padding(.top, 30)
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(accounts.indices, id: \.self) { index in
                                    AccountThumb(
                                        account: accounts[index],
                                        hideValue: isHidingValues
                                    )
                                    .frame(minWidth: 250)
                                    .accessibilityIdentifier(AccessibilityIdentifier.Home.accountItem.build() + String(index))
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        DynamicStack(orientation: isLargeTypeSize ? .vertical : .horizontal) {
                            Text("Cards")
                                .font(AppFont.headline)
                                .foregroundStyle(AppColor.onBackground)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityIdentifier(AccessibilityIdentifier.Home.cardsLabel.build())
                                .accessibilityAddTraits(.isHeader)
                                
                            Spacer()
                            
                            Text(String.localizedCurrency(from: cards.map{$0.balance}.reduce(0, +)).masked(isHidingValues))
                                .font(AppFont.body1)
                                .foregroundStyle(AppColor.onBackground)
                                .frame(maxWidth: .infinity, alignment: isLargeTypeSize ? .leading : .trailing)
                                .accessibilityIdentifier(AccessibilityIdentifier.Home.totalCardsBalanceLabel.build())
                                .accessibilityLabel("Total balance, \(String.localizedCurrency(from: cards.map{$0.balance}.reduce(0, +)))")
                        }
                        .padding(.top, 30)
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(cards.indices, id: \.self) { index in
                                    DebitCreditCardThumb(
                                        card: cards[index],
                                        hideValue: isHidingValues
                                    )
                                    .frame(minWidth: 250)
                                    .accessibilityIdentifier(AccessibilityIdentifier.Home.cardItem.build() + String(index))
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Insurance")
                            .font(AppFont.headline)
                            .foregroundStyle(AppColor.onBackground)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 30)
                            .padding(.horizontal)
                            .accessibilityIdentifier(AccessibilityIdentifier.Home.insurancesLabel.build())
                            .accessibilityAddTraits(.isHeader)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(insurances.indices, id: \.self) { index in
                                    InsuranceThumb(
                                        insurance: insurances[index]
                                    )
                                    .frame(minWidth: 250)
                                    .accessibilityIdentifier(AccessibilityIdentifier.Home.insuranceItem.build() + String(index))
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Budget history")
                            .font(AppFont.headline)
                            .foregroundStyle(AppColor.onBackground)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 30)
                            .padding(.horizontal)
                            .accessibilityIdentifier(AccessibilityIdentifier.Home.budgetHistoryLabel.build())
                            .accessibilityAddTraits(.isHeader)
                        
                        BudgetGraph(budgets: budgets)
                            .frame(minHeight: 300)
                    }
                }
            }
            .toolbarBackground(AppColor.surface, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // TODO: open menu
                    }, label: {
                        Image("Logo")
                            .resizable()
                            .frame(
                                width: UIFontMetrics.default.scaledValue(for: 35),
                                height: UIFontMetrics.default.scaledValue(for: 35))
                            .accessibilityIgnoresInvertColors()
                    })
                    .accessibilityLabel("Demo Bank Menu")
                    .accessibilityHint("Opens menu with all options")
                    .accessibilityInputLabels(["Menu"])
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isHidingValues.toggle() }, label: {
                        VStack {
                            Image(systemName: isHidingValues ? "eye" : "eye.slash")
                            Text(isHidingValues ? "Show" : "Hide")
                                .font(AppFont.caption)
                        }
                    })
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.hideValuesButton.build())
                    .accessibilityLabel(isHidingValues ? "Show values" : "Hide values")
                    .accessibilityHint(isHidingValues ? "Shows account details" : "Hides account details")
                }
            }
        }
        .onAppear {
            if (reduceMotion) {
                loadData()
            } else {
                withAnimation {
                    loadData()
                }
            }
        }
    }
    
    private var isLargeTypeSize: Bool {
        typeSize > .accessibility1
    }
    
    private func loadData() {
        accounts = Stub.accounts
        cards = Stub.cards
        insurances = Stub.insurances
        budgets = Stub.budgets
    }
}

#Preview {
    HomeView()
}
