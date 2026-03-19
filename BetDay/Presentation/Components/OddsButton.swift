//
//  OddsButton.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI

struct OddsButton: View {
    let label: String
    let odds: Double
    let isSelected: Bool
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
            }
            action()
        }) {
            VStack(spacing: 2) {
                Text(label)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundStyle(isSelected ? Color.betBackground : Color.betTextSecondary)
                Text(String(format: "%.2f", odds))
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? Color.betBackground : Color.betTextPrimary)
            }
            .frame(width: 60, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(isSelected ? Color.betAccent : Color.betSurfaceAlt)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(
                                isSelected ? Color.betAccent : Color.betSurfaceAlt.opacity(0),
                                lineWidth: 1.5
                            )
                    )
            )
            .scaleEffect(isPressed ? 0.88 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        OddsButton(label: "1", odds: 1.60, isSelected: true)  {}
        OddsButton(label: "X", odds: 3.25, isSelected: false) {}
        OddsButton(label: "2", odds: 4.10, isSelected: false) {}
    }
    .padding()
    .background(Color.betBackground)
}
