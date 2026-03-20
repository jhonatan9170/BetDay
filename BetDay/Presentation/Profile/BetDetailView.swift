//
//  BetDetailView.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import SwiftUI

struct BetDetailView: View {
    let bet: PlacedBet
    let onSimulate: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var isPulsing = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.betBackground.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        statusHero
                        matchCard
                        detailsCard
                        if bet.status == .pending {
                            simulateButton
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("Bet Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.betBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.betTextSecondary)
                    }
                }
            }
        }
    }

    private var statusHero: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(bet.status.color.opacity(isPulsing ? 0.15 : 0.08))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isPulsing ? 1.12 : 1.0)
                Circle()
                    .fill(bet.status.color.opacity(0.2))
                    .frame(width: 76, height: 76)
                Text(bet.status.emoji)
                    .font(.system(size: 36))
            }
            .onAppear {
                guard bet.status == .pending else { return }
                withAnimation(.easeInOut(duration: 1.2).repeatForever()) { isPulsing.toggle() }
            }
            Text(bet.status.rawValue)
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundStyle(bet.status.color)
            Text("Placed \(bet.placedAt.formatted(.dateTime.day().month().year().hour().minute()))")
                .font(.system(size: 12))
                .foregroundStyle(Color.betTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.betSurface))
    }

    private var matchCard: some View {
        VStack(spacing: 16) {
            Text(bet.leagueFlag + " " + bet.leagueName)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.betTextSecondary)
            HStack {
                Text(bet.homeTeam)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.betTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("VS")
                    .font(.system(size: 12, weight: .black))
                    .foregroundStyle(Color.betTextSecondary)
                    .padding(.horizontal, 12)
                Text(bet.awayTeam)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.betTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.betSurface))
    }

    private var detailsCard: some View {
        VStack(spacing: 0) {
            detailRow(title: "Selection", value: "\(bet.selection.fullLabel) (\(bet.selection.label))")
            Divider().background(Color.betSurfaceAlt)
            detailRow(title: "Odds", value: String(format: "%.2f", bet.odds), valueColor: .betAccentWarm)
            Divider().background(Color.betSurfaceAlt)
            detailRow(title: "Bet ID", value: String(bet.id.prefix(8)).uppercased())
        }
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.betSurface))
    }

    private func detailRow(title: String, value: String, valueColor: Color = .betTextPrimary) -> some View {
        HStack {
            Text(title).font(.system(size: 14)).foregroundStyle(Color.betTextSecondary)
            Spacer()
            Text(value).font(.system(size: 14, weight: .semibold)).foregroundStyle(valueColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private var simulateButton: some View {
        Button(action: onSimulate) {
            Label("Simulate Result", systemImage: "dice")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.betBackground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(RoundedRectangle(cornerRadius: 14).fill(Color.betAccent))
        }
        .buttonStyle(.plain)
    }
    
}
