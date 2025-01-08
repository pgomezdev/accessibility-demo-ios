//
//  InboxView.swift
//  AccessibilityDemo
//

import SwiftUI

struct InboxView: View {
    
    @State var inboxItems: [InboxMessage] = []
    @State var isEditing = false
    
    @Namespace private var warningsRotorNamespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollViewReader { scrollView in
                    List {
                        ForEach(inboxItems.indices, id: \.self) { index in
                            HStack {
                                if (isEditing) {
                                    Button(action: {
                                        inboxItems.remove(at: index)
                                    }, label: {
                                        Image(systemName: "trash.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(Color.customNegative)
                                            .frame(
                                                width: UIFontMetrics.default.scaledValue(for: 35),
                                                height: UIFontMetrics.default.scaledValue(for: 35))
                                    })
                                    .accessibilityLabel("inbox.delete.button.title")
                                    .accessibilityHint(
                                        Text(
                                            String.localizedStringWithFormat(
                                                NSLocalizedString("inbox.delete.accessibilityHint", comment: "Action for inbox item deletion"),
                                                inboxItems[index].type.rawValue,
                                                "\(inboxItems[index].message.prefix(30))"
                                            )
                                        )
                                    )
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        iconFor(inboxItem: inboxItems[index])
                                            .frame(
                                                width: UIFontMetrics.default.scaledValue(for: 20),
                                                height: UIFontMetrics.default.scaledValue(for: 20))
                                            .accessibilityLabel(inboxItems[index].type.accessibilityLabel)
                                            .accessibilitySortPriority(2)
                                        
                                        Text(inboxItems[index].date.medium)
                                            .font(.brandCustom(for: .subheadline))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .accessibilityLabel(inboxItems[index].date.long)
                                            .accessibilitySortPriority(3)
                                    }
                                    
                                    Text(inboxItems[index].message)
                                        .font(.brandCustom(for: .body))
                                        .accessibilitySortPriority(1)
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityRotorEntry(id: inboxItems[index].id, in: warningsRotorNamespace)
                            }
                            .padding(.vertical)
                        }
                        .onDelete(perform: { indexSet in
                            inboxItems.remove(atOffsets: indexSet)
                        })
                    }
                    .listStyle(.plain)
                    .accessibilityElement(children: .contain)
                    .accessibilityRotor(Text("inbox.list.accessibilityRotor")) {
                        ForEach(inboxItems) { item in
                            if (item.type == .warning) {
                                AccessibilityRotorEntry(Text(item.message), id: item.id, in: warningsRotorNamespace) {
                                    scrollView.scrollTo(item.id)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("inbox.navigation.title")
            .toolbarBackground(Color.background, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isEditing.toggle() }, label: {
                        Text(isEditing ? "inbox.edit.button.done" : "inbox.edit.button.edit")
                            .font(.brandCustom(for: .headline))
                    })
                    .accessibilityIdentifier(AccessibilityIdentifier.Inbox.editButton.build())
                    .accessibilityHint(isEditing ? "inbox.edit.button.hint.done" : "inbox.edit.button.hint.edit")
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        inboxItems = StubData.inboxItems
    }
    
    private func iconFor(inboxItem: InboxMessage) -> AnyView {
        let (image, color) = switch inboxItem.type {
        case .information:
            ("info.circle", Color.gray)
        case .warning:
            ("exclamationmark.triangle", Color.customWarning)
        case .payment:
            ("arrow.up.forward.circle", Color.customNegative)
        case .income:
            ("arrow.down.backward.circle", Color.customPositive)
        }
             
        return AnyView(
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
        )
    }
}

#Preview {
    InboxView()
}
