//
//  StatusBadge.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI
 
 
struct StatusBadge: View {
    let status: BetStatus
    var body: some View {
        Text(status.rawValue)
            .font(.system(size: 10, weight: .black, design: .rounded))
            .tracking(0.6)
            .foregroundStyle(status.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(status.color.opacity(0.15))
            )
    }
}

#Preview {
    VStack(spacing: 12) {
        StatusBadge(status: .won)
        StatusBadge(status: .lost)
        StatusBadge(status: .pending)
    }
    .padding()
}
 
