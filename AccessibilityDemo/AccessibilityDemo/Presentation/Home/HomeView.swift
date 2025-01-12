//
//  HomeView.swift
//  AccessibilityDemo
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dynamicTypeSize) var typeSize
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @ScaledMetric var navBarImageSize: CGFloat = 30
    
    @State var isMenuPresented = false
    @State var isHidingValues = false
    @State var isShowingAlert = false
    @State var accounts: [Account] = []
    @State var cards: [PaymentCard] = []
    @State var insurances: [Insurance] = []
    @State var budgets: [Budget] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
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
            .sheet(isPresented: $isMenuPresented) {
                menuView
            }
            .toolbarBackground(Color.background, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        openMenu()
                    }, label: {
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: navBarImageSize, height: navBarImageSize)
                            .accessibilityIgnoresInvertColors()
                    })
                    .accessibilityLabel("home.menu.button.accessibilityLabel")
                    .accessibilityHint("home.menu.button.accessibilityHint")
                    .accessibilityInputLabels(["home.menu.button.accessibilityInputLabel"])
                }
                
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: navBarImageSize, height: navBarImageSize)
                        .accessibilityIgnoresInvertColors()
                        .accessibilityHidden(true)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle(isOn: $isHidingValues) {
                        Text(isHidingValues ? "home.hideValues.button.show" : "home.hideValues.button.hide")
                    }
                    .toggleStyle(SwitchToggleStyle())
                    .accessibilityIdentifier(AccessibilityIdentifier.Home.hideValuesButton.build())
                    .accessibilityValue(isHidingValues ? "home.hideValues.button.accessibilityValue.on" : "home.hideValues.button.accessibilityValue.off")
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
    
    var menuView: some View {
        NavigationView {
            List {
                Section(header: Text("menu.general.section")) {
                    Label("menu.profile.title", systemImage: "person.crop.circle")
                    Label("menu.notifications.title", systemImage: "bell")
                }
                
                Section(header: Text("menu.preferences.section")) {
                    Label("menu.appearance.title", systemImage: "paintbrush")
                    NavigationLink(destination: PrivacyView()) {
                        Label("menu.privacy.title", systemImage: "lock")
                    }
                }
                
                Section(header: Text("menu.about.section")) {
                    NavigationLink(destination: AboutView()) {
                        Label("menu.about.tilte", systemImage: "info.circle")
                    }
                }
                
                Section {
                    Button(action: {
                        isShowingAlert = true
                    }) {
                        Label("menu.logout.title", systemImage: "escape")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("menu.logout.alert.title"),
                            message: Text("menu.logout.alert.message"),
                            primaryButton: .destructive(Text("menu.logout.alert.button.confirm")) {
                                // TODO: log out
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationTitle("menu.title")
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
    
    func openMenu() {
        withAnimation {
            isMenuPresented.toggle()
        }
    }
}

#Preview {
    HomeView()
}
