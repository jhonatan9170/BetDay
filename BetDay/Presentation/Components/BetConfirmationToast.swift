//
//  BetConfirmationToast.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI
  
struct BetConfirmationToast: View {
    
    let selection: BetConfirmationModel
 
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundStyle(Color.betAccent)
 
            VStack(alignment: .leading, spacing: 2) {
                Text("Bet placed!")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.betTextPrimary)
                Text("\(selection.homeTeam) vs \(selection.awayTeam) · \(selection.selection)")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(Color.betTextSecondary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color.betSurface)
                .shadow(color: .black.opacity(0.4), radius: 12, y: 4)
        )
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

struct BetConfirmationModel {
    let homeTeam: String
    let awayTeam: String
    let selection: String
    
    init(homeTeam: String, awayTeam: String, selection: String) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.selection = selection
    }
        
    
    init(from bet: PlacedBet) {
        self.homeTeam = bet.homeTeam
        self.awayTeam = bet.awayTeam
        self.selection = bet.selection.fullLabel
    }
}

#Preview {
    let model = BetConfirmationModel(homeTeam: "Porto", awayTeam: "Liverpool FC", selection: "1 (Home Win)")
    BetConfirmationToast(selection: model)
        .padding()
}

