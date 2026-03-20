//
//  HomeView.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI

struct HomeView: View {
    @State private var vm: HomeViewModel = DependencyContainer.shared.makeHomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.betBackground.ignoresSafeArea()

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 24, pinnedViews: .sectionHeaders) {
                        switch vm.loadState {
                        case .idle, .loading:
                            skeletonSection
                        case .loaded:
                            eventsSection
                        case .failed(let message):
                            errorView(message)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }

                if let bet = vm.confirmedBet {
                    VStack {
                        Spacer()
                        BetConfirmationToast(
                            selection: BetConfirmationModel(from: bet)
                        )
                        .padding(.top, 12)
                        
                    }
                    .ignoresSafeArea(edges: .top)
                    .zIndex(10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .navigationTitle("")
            .toolbar { navBar }
            .task { await vm.loadEvents() }
            .alert("Oops", isPresented: Binding(
                get: { vm.placeBetError != nil },
                set: { if !$0 { vm.placeBetError = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(vm.placeBetError ?? "")
            }
        }
    }

    @ToolbarContentBuilder
    private var navBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            (Text("betday").font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundStyle(Color.betTextPrimary)
            + Text(".lite").font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundStyle(Color.betAccent))
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Text(Date().formatted(.dateTime.weekday(.wide).month().day()).uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.betTextSecondary)
        }
    }

    @ViewBuilder
    private var eventsSection: some View {
        ForEach(vm.groupedEvents, id: \.hour) { group in
            Section {
                ForEach(group.events) { event in
                    EventCard(
                        event: event,
                        isConfirmed: vm.confirmedBet?.eventId == event.id
                    ) { selection in
                        Task { await vm.placeBet(on: event, selection: selection) }
                    }
                }
            } header: {
                HStack {
                    Text(group.hour)
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color.betAccent)
                    Rectangle()
                        .fill(Color.betAccent.opacity(0.2))
                        .frame(height: 1)
                }
                .padding(.vertical, 4)
                .background(Color.betBackground)
            }
        }
    }

    private var skeletonSection: some View {
        VStack(spacing: 12) {
            ForEach(0..<5, id: \.self) { _ in SkeletonCard() }
        }
    }

    @ViewBuilder
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 42))
                .foregroundStyle(Color.betTextSecondary)
            Text("Couldn't load events")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.betTextPrimary)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(Color.betTextSecondary)
                .multilineTextAlignment(.center)
            Button("Try again") { vm.retry() }
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 24).padding(.vertical, 10)
                .background(Capsule().fill(Color.betAccent))
                .foregroundStyle(Color.betBackground)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}
