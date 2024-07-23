//
//  InboxView.swift
//  AccessibilityDemo
//

import SwiftUI

struct InboxView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    @State var inboxItems: [InboxItem] = []
    @State var isEditing = false
    
    @Namespace private var warningsRotorNamespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.background
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
                                            .foregroundStyle(AppColor.sad)
                                            .frame(
                                                width: UIFontMetrics.default.scaledValue(for: 35),
                                                height: UIFontMetrics.default.scaledValue(for: 35))
                                    })
                                    .accessibilityLabel("Delete message")
                                    .accessibilityHint("Delete \(inboxItems[index].type.rawValue) message starting with: \(inboxItems[index].message.prefix(30))")
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        iconFor(inboxItem: inboxItems[index])
                                            .frame(
                                                width: UIFontMetrics.default.scaledValue(for: 20),
                                                height: UIFontMetrics.default.scaledValue(for: 20))
                                            .accessibilityLabel(inboxItems[index].type.rawValue)
                                            .accessibilitySortPriority(2)
                                        
                                        Text(inboxItems[index].date.medium)
                                            .font(AppFont.body2)
                                            .foregroundStyle(AppColor.onSurface)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .accessibilityLabel(inboxItems[index].date.long)
                                            .accessibilitySortPriority(3)
                                    }
                                    
                                    Text(inboxItems[index].message)
                                        .font(AppFont.body1)
                                        .foregroundStyle(AppColor.onSurface)
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
                    .accessibilityRotor(Text("Warnings")) {
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
            .navigationTitle("Inbox")
            .toolbarBackground(AppColor.surface, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isEditing.toggle() }, label: {
                        Text(isEditing ? "Done" : "Edit")
                            .font(AppFont.button)
                    })
                    .accessibilityIdentifier(AccessibilityIdentifier.Inbox.editButton.build())
                    .accessibilityHint(isEditing ? "Finishes editing messages" : "Edits messages")
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
    
    private func loadData() {
        inboxItems = Stub.inboxItems
    }
    
    private func iconFor(inboxItem: InboxItem) -> AnyView {
        let (image, color) = switch inboxItem.type {
        case .information:
            ("info.circle", AppColor.neutral)
        case .warning:
            ("exclamationmark.triangle", AppColor.concerned)
        case .payment:
            ("arrow.up.forward.circle", AppColor.sad)
        case .income:
            ("arrow.down.backward.circle", AppColor.happy)
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
