//
//  EventCard.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation
import SwiftUI

struct EventCard: View, Equatable {
    
    static func == (lhs: EventCard, rhs: EventCard) -> Bool {
        lhs.event.id == rhs.event.id &&
        lhs.isConfirmed == rhs.isConfirmed
    }
    
    let event: BetEvent
    let isConfirmed: Bool
    let onBet: (BetSelection) async -> Bool
    
    @State private var selectedBet: BetSelection? = nil
    
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    private var timeString: String {
        Self.formatter.string(from: event.kickoffDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            header
            
            content
            
            if isConfirmed {
                confirmationView
            }
        }
        .padding(16)
        .background(backgroundView)
        .animation(.spring(duration: 0.3), value: isConfirmed)
    }
}

// MARK: - Subviews (reduce trabajo en body)
private extension EventCard {
    
    var header: some View {
        HStack(spacing: 6) {
            Text(event.league.flag)
                .font(.caption)
            
            Text(event.league.name)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.betTextSecondary)
            
            Spacer()
            
            Text(timeString)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundStyle(Color.betAccent)
        }
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.homeTeam)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.betTextPrimary)
                
                Text(event.awayTeam)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.betTextPrimary)
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                oddsButton("1", event.odds.home, .home)
                oddsButton("X", event.odds.draw, .draw)
                oddsButton("2", event.odds.away, .away)
            }
        }
    }
    
    var confirmationView: some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark.seal.fill")
                .font(.caption2)
            
            Text("Bet added to your slip")
                .font(.system(size: 11, weight: .medium))
        }
        .foregroundStyle(Color.betAccent)
        .transition(.opacity.combined(with: .scale))
    }
    
    var backgroundView: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.betSurface)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        isConfirmed
                        ? Color.betAccent.opacity(0.5)
                        : Color.white.opacity(0.05),
                        lineWidth: 1
                    )
            )
    }
    
    func oddsButton(_ label: String, _ odds: Double, _ selection: BetSelection) -> some View {
        OddsButton(
            label: label,
            odds: odds,
            isSelected: selectedBet == selection
        ) {
            placeOrToggle(selection)
        }
    }
}

private extension EventCard {
    
    func placeOrToggle(_ sel: BetSelection) {
        Task {
            let needSelect = await onBet(sel)
            await MainActor.run {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                    if needSelect {
                        selectedBet = sel
                    } else if selectedBet == sel {
                        selectedBet = nil
                    }
                }
            }
        }
    }
}

 
#Preview {
    let events: [BetEvent] = [
        BetEvent(
            id: "p1",
            league: League(name: "Premier League", flag: "🏴󠁧󠁢󠁥󠁮󠁧󠁿"),
            homeTeam: "Chelsea FC", awayTeam: "Manchester United",
            kickoffDate: Calendar.current.date(bySettingHour: 17, minute: 30, second: 0, of: Date())!,
            odds: Odds(home: 1.60, draw: 2.05, away: 1.75)
        ),
        BetEvent(
            id: "p2",
            league: League(name: "Champions League", flag: "🏆"),
            homeTeam: "Porto", awayTeam: "Liverpool FC",
            kickoffDate: Calendar.current.date(bySettingHour: 18, minute: 45, second: 0, of: Date())!,
            odds: Odds(home: 3.74, draw: 2.10, away: 1.75)
        ),
        BetEvent(
            id: "p3",
            league: League(name: "Super Lig", flag: "🇹🇷"),
            homeTeam: "Galatasaray", awayTeam: "Besiktas",
            kickoffDate: Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!,
            odds: Odds(home: 1.35, draw: 2.80, away: 6.25)
        ),
    ]
 
    ScrollView {
        VStack(spacing: 12) {
            ForEach(events) { event in
                EventCard(event: event, isConfirmed: event.id == "p2") { _ in Bool.random() }
            }
        }
        .padding()
    }
    .background(Color.betBackground)
}

