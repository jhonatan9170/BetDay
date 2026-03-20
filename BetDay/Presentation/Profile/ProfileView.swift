//
//  ProfileView.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import SwiftUI


struct ProfileView: View {
    @State private var vm: ProfileViewModel = DependencyContainer.shared.makeProfileViewModel()
    @State private var selectedBet: PlacedBet? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.betBackground.ignoresSafeArea()

                if vm.isLoading {
                    ProgressView()
                        .tint(Color.betAccent)
                } else if vm.bets.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.bets) { bet in
                                BetSlipCard(bet: bet)
                                    .onTapGesture { selectedBet = bet }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("My Bets")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.betBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task { await vm.loadBets() }
            .sheet(item: $selectedBet) { bet in
                BetDetailView(bet: bet, onSimulate: {
                    Task {
                        await vm.simulateResult(for: bet)
                        selectedBet = nil
                    }
                })
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle().fill(Color.betSurface).frame(width: 90, height: 90)
                Image(systemName: "ticket")
                    .font(.system(size: 36))
                    .foregroundStyle(Color.betTextSecondary)
            }
            Text("No bets yet")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color.betTextPrimary)
            Text("Head to Today's events and\nplace your first bet.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.betTextSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
}

struct BetSlipCard: View {
    let bet: PlacedBet

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 3)
                .fill(bet.status.color)
                .frame(width: 4)
                .padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(bet.leagueFlag + " " + bet.leagueName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.betTextSecondary)
                    Spacer()
                    StatusBadge(status: bet.status)
                }
                Text("\(bet.homeTeam) vs \(bet.awayTeam)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.betTextPrimary)
                HStack(spacing: 8) {
                    Text(bet.selection.fullLabel)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.betBackground)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Capsule().fill(Color.betAccent))
                    Text("@")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.betTextSecondary)
                    Text(String(format: "%.2f", bet.odds))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color.betAccentWarm)
                }
            }
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color.betTextSecondary)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14, style: .continuous).fill(Color.betSurface))
    }
}
