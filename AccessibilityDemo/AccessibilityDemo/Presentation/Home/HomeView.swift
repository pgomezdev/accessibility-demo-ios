//
//  HomeView.swift
//  AccessibilityDemo
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dynamicTypeSize) var typeSize
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @ScaledMetric var navBarImageSize: CGFloat = 30
    
    @State var isHidingValues = false
    @State var accounts: [Account] = []
    @State var cards: [PaymentCard] = []
    @State var insurances: [Insurance] = []
    @State var budgets: [Budget] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        accountsView
                        cardsView
                        insuranceView
                        budgetView
                    }
                    .padding(.bottom)
                }
            }
            .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // TODO: open menu
                    }, label: {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: navBarImageSize, height: navBarImageSize)
                            .accessibilityIgnoresInvertColors()
                    })
                    .accessibilityLabel("home.menu.button.accessibilityLabel")
                    .accessibilityHint("home.menu.button.accessibilityHint")
                    .accessibilityInputLabels(["home.menu.button.accessibilityInputLabel"])
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isHidingValues.toggle() }, label: {
                        Image(systemName: isHidingValues ? "eye" : "eye.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: navBarImageSize, height: navBarImageSize)
                    })
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.hideValuesButton.build())
                    .accessibilityLabel(isHidingValues ? "home.hideValues.button.accessibilityLabel.show" : "home.hideValues.button.accessibilityLabel.hide")
                    .accessibilityHint(isHidingValues ? "home.hideValues.button.accessibilityHint.show" : "home.hideValues.button.accessibilityHint.hide")
                    .accessibilityInputLabels(isHidingValues ? ["home.hideValues.button.accessibilityInputLabel.show"] : ["home.hideValues.button.accessibilityInputLabel.hide"])
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    var accountsView: some View {
        Group {
            DynamicStack(orientation: typeSize.isAccessibilitySize ? .vertical : .horizontal, horizontalAlignment: .leading) {
                Text("home.accounts.title")
                    .font(.brandCustom(for: .headline))
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.accountsTitle.build())
                    .accessibilityAddTraits(.isHeader)
                    
                if !typeSize.isAccessibilitySize {
                    Spacer()
                }
                
                Text(totalAccountsBalance)
                    .font(.brandCustom(for: .body))
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.totalAccountsBalanceLabel.build())
                    .accessibilityLabel(totalAccountsBalance)
                    .accessibilityHidden(isHidingValues)
            }
            .padding(.top, 30)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(accounts.indices, id: \.self) { index in
                        AccountViewItem(account: accounts[index], hideValue: isHidingValues)
                        .frame(minWidth: 280)
                        .accessibilityIdentifier(AccessibilityIdentifier.Home.accountCardItem.build() + String(index))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var cardsView: some View {
        Group {
            DynamicStack(orientation: typeSize.isAccessibilitySize ? .vertical : .horizontal, horizontalAlignment: .leading) {
                Text("home.paymentCards.title")
                    .font(.brandCustom(for: .headline))
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.cardsTitle.build())
                    .accessibilityAddTraits(.isHeader)
                    
                if !typeSize.isAccessibilitySize {
                    Spacer()
                }
                
                Text(totalCardsBalance)
                    .font(.brandCustom(for: .body))
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.totalCardsBalanceLabel.build())
                    .accessibilityLabel(totalCardsBalance)
                    .accessibilityHidden(isHidingValues)
            }
            .padding(.top, 30)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(cards.indices, id: \.self) { index in
                        PaymentViewItem(
                            card: cards[index],
                            hideValue: isHidingValues
                        )
                        .frame(minWidth: 280)
                        .accessibilityIdentifier(AccessibilityIdentifier.Home.cardItem.build() + String(index))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var insuranceView: some View {
        Group {
            Text("home.insurance.title")
                .font(.brandCustom(for: .headline))
                .padding(.top, 30)
                .padding(.horizontal)
                .accessibilityIdentifier(AccessibilityIdentifier.Home.insurancesTitle.build())
                .accessibilityAddTraits(.isHeader)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(insurances.indices, id: \.self) { index in
                        InsuranceViewItem(insurance: insurances[index])
                        .frame(minWidth: 280)
                        .accessibilityIdentifier(AccessibilityIdentifier.Home.insuranceItem.build() + String(index))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var budgetView: some View {
        Group {
            Text("home.budget.title")
                .font(.brandCustom(for: .headline))
                .padding(.top, 30)
                .padding(.horizontal)
                .accessibilityIdentifier(AccessibilityIdentifier.Home.budgetHistoryTitle.build())
                .accessibilityAddTraits(.isHeader)
            
            BudgetGraph(budgets: budgets)
                .frame(minHeight: 300)
        }
    }
    
    var totalAccountsBalance: String {
        let balance = String.localizedCurrency(from: accounts.reduce(0) { $0 + $1.balance })
        return isHidingValues ? balance.masked() : balance
    }
    
    var totalCardsBalance: String {
        let balance = String.localizedCurrency(from: cards.reduce(0) { $0 + $1.balance })
        return isHidingValues ? balance.masked() : balance
    }
    
    func loadData() {
        accounts = StubData.accounts
        cards = StubData.cards
        insurances = StubData.insurances
        budgets = StubData.budgets
    }
}

#Preview {
    HomeView()
}
