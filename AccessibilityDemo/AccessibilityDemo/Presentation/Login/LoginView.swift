//
//  LoginView.swift
//  AccessibilityDemo
//

import SwiftUI

struct LoginView: View {
    
    @State private var enteredPin = ""
    
    var onLoginSuccess: (() -> Void)?
    
    private let pinLength: Int = 4
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("login.content.title")
                    .font(.brandCustom(for: .title))
                    .accessibilityIdentifier(AccessibilityIdentifier.Login.contentTitleLabel.build())
                
                Text("login.content.message")
                    .font(.brandCustom(for: .body))
                    .accessibilityIdentifier(AccessibilityIdentifier.Login.contentMessageLabel.build())
                
                HStack(spacing: 10) {
                    ForEach(0..<4) { index in
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 15, height: 15)
                            .background(Circle().fill(index < enteredPin.count ? Color.customWarning : Color.clear))
                            .accessibilityIdentifier(AccessibilityIdentifier.Login.pinIndicator.build() + "_\(index)")
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("login.pin.indicator.label")
                .accessibilityValue(Text(
                    String.localizedStringWithFormat(
                        NSLocalizedString("login.pin.indicator.value", comment: "Describes the current pin entry position"),
                        enteredPin.count + 1,
                        pinLength
                    ))
                )
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 20) {
                            ForEach(1...3, id: \ .self) { col in
                                let number = row * 3 + col
                                PinButton(number: number) { number in
                                    handlePinInput(number)
                                }
                            }
                        }
                    }
                    PinButton(number: 0) { number in
                        handlePinInput(number)
                    }
                }
                
                Button("login.clear.button.title", action: {
                    guard !enteredPin.isEmpty else { return }
                    enteredPin.removeLast()
                })
                    .foregroundColor(.red)
                    .accessibilityHint("login.clear.button.hint")
            }
            .padding()
        }
    }
    
    private func handlePinInput(_ number: Int) {
        guard enteredPin.count < pinLength else { return }
        enteredPin.append("\(number)")
        if enteredPin.count == pinLength && enteredPin == "1234" {
            onLoginSuccess?()
        } else if enteredPin.count == pinLength {
            enteredPin = ""
        }
    }
}

#Preview {
    LoginView()
}
