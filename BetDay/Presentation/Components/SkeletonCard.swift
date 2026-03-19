//
//  SkeletonCard.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI
  
struct SkeletonCard: View {
    @State private var shimmer = false
 
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(shimmerGradient)
                    .frame(width: 80, height: 10)
                Spacer()
                RoundedRectangle(cornerRadius: 4)
                    .fill(shimmerGradient)
                    .frame(width: 40, height: 10)
            }
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 4).fill(shimmerGradient).frame(width: 120, height: 14)
                    RoundedRectangle(cornerRadius: 4).fill(shimmerGradient).frame(width: 100, height: 14)
                }
                Spacer()
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10).fill(shimmerGradient).frame(width: 60, height: 44)
                    }
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.betSurface))
        .onAppear { withAnimation(.easeInOut(duration: 1.2).repeatForever()) { shimmer.toggle() } }
    }
 
    private var shimmerGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.betSurfaceAlt,
                Color.betSurfaceAlt.opacity(0.4),
                Color.betSurfaceAlt
            ],
            startPoint: shimmer ? .leading : .trailing,
            endPoint:   shimmer ? .trailing : .leading
        )
    }
}

#Preview {
    SkeletonCard()
}
