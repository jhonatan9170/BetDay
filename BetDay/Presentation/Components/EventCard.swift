//
//  EventCard.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI

struct EventCard: View {
    
    let event: BetEvent
    let isConfirmed: Bool
    let onBet: (BetSelection) -> Void
    
    @State private var selectedBet: BetSelection? = nil
    
    private var timeString: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: event.kickoffDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
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
                    OddsButton(label: "1", odds: event.odds.home, isSelected: selectedBet == .home) {
                        placeOrToggle(.home)
                    }
                    OddsButton(label: "X", odds: event.odds.draw, isSelected: selectedBet == .draw) {
                        placeOrToggle(.draw)
                    }
                    OddsButton(label: "2", odds: event.odds.away, isSelected: selectedBet == .away) {
                        placeOrToggle(.away)
                    }
                }
            }

            if isConfirmed {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.caption2)
                    Text("Bet added to your slip")
                        .font(.system(size: 11, weight: .medium))
                }
                .foregroundStyle(Color.betAccent)
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.betSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(
                            isConfirmed ? Color.betAccent.opacity(0.5) : Color.white.opacity(0.05),
                            lineWidth: 1
                        )
                )
        )
        .animation(.spring(duration: 0.3), value: isConfirmed)
    }

    private func placeOrToggle(_ sel: BetSelection) {
        withAnimation(.spring(duration: 0.25)) {
            if selectedBet == sel {
                selectedBet = nil
            } else {
                selectedBet = sel
                onBet(sel)
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
                EventCard(event: event, isConfirmed: event.id == "p2") { _ in }
            }
        }
        .padding()
    }
    .background(Color.betBackground)
}

