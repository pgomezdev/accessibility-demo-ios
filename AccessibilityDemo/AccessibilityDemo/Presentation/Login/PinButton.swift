//
//  PinButton.swift
//  AccessibilityDemo
//

import SwiftUI
import CoreHaptics

/**
 A custom view representing a pin button for numeric entry in a bank app.
 
 This button integrates haptic feedback to enhance accessibility for users, especially for VoiceOver users, by providing tactile feedback when a button is focused.
 The haptics are designed to convey additional information discreetly, helping to ensure security and usability in sensitive contexts like PIN entry.
 */
struct PinButton: View {
    
    let number: Int
    var onTapped: (Int) -> Void
    
    /// Tracks the accessibility focus state of the button. Used to trigger haptic feedback when the button gains focus.
    @AccessibilityFocusState
    private var isFocused: Bool
    
    /// The haptic engine responsible for generating tactile feedback.
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button(action: {
            onTapped(number)
        }) {
            Text("\(number)")
                .font(.brandCustom(for: .headline))
                .frame(width: 80, height: 80)
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .cornerRadius(40)
                .accessibilityHidden(true)
        }
        .accessibilityLabel("\(number)")
        .accessibilityAddTraits(.isKeyboardKey)
        .accessibilityFocused($isFocused)
        .accessibilityInputLabels(["\(number)"])
        .onChange(of: isFocused) { newValue, _ in
            if isFocused {
                if number == 0 {
                    triggerLongHaptic()
                } else {
                    triggerGroupedHaptics(for: number)
                }
            }
        }
        .onAppear {
            prepareHaptics()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine creation error: \(error.localizedDescription)")
        }
    }
    
    /**
     Calculates the haptic timing pattern for a given number.
     
     - Parameter value: The number for which to generate a haptic pattern.
     - Returns: An array of time offsets for the haptic events.
     */
    private func hapticTimes(for value: Int) -> [Double] {
        let step = 0.3 // Base interval between events.
        let jump = 0.4 // Larger interval for grouped haptics.
        switch value {
        case 1:
            return [
                step*0
            ]
        case 2:
            return [
                step*0, step*1
            ]
        case 3:
            return [
                step*0, step*1, step*2
            ]
        case 4:
            return [
                step*0, step*1,
                (jump*1)+step*2, (jump*1)+step*3
            ]
        case 5:
            return [
                step*0, step*1, step*2,
                (jump*1)+step*3, (jump*1)+step*4
            ]
        case 6:
            return [
                step*0, step*1, step*2,
                (jump*1)+step*3, (jump*1)+step*4, (jump*1)+step*5
            ]
        case 7:
            return [
                step*0, step*1, step*2,
                (jump*1)+step*3, (jump*1)+step*4,
                (jump*2)+step*5, (jump*2)+step*6
            ]
        case 8:
            return [
                step*0, step*1, step*2, step*3,
                (jump*1)+step*4, (jump*1)+step*5, (jump*1)+step*6, (jump*1)+step*7
            ]
        case 9:
            return [
                step*0, step*1, step*2,
                (jump*1)+step*3, (jump*1)+step*4, (jump*1)+step*5,
                (jump*2)+step*6, (jump*2)+step*7, (jump*2)+step*8
            ]
        default:
            return []
        }
    }
    
    /**
     Triggers a patterned haptic feedback sequence for a given number.
     
     - Parameter value: The number associated with the haptic pattern.
     */
    private func triggerGroupedHaptics(for value: Int) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let pattern: [(time: Double, intensity: Float, sharpness: Float)] = hapticTimes(for: value).map { ($0, 1.0, 1.0) }
        
        for item in pattern {
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: item.intensity),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: item.sharpness)
                ],
                relativeTime: item.time
            )
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    /**
     Triggers a long continuous haptic feedback.
     
     Used for the `0` button to provide a distinct tactile response.
     */
    private func triggerLongHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let duration: TimeInterval = 0.6
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        
        let longHapticEvent = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0,
            duration: duration
        )
        
        events.append(longHapticEvent)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PinButton(number: 0, onTapped: {_ in})
}
