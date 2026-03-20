//
//  HomeViewModel.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {

    var loadState: HomeViewState = .idle
    var confirmedBet: PlacedBet? = nil
    var placeBetError: String? = nil

    private let fetchEventsUseCase: FetchEventsUseCaseProtocol
    private let placeBetUseCase: PlaceBetUseCaseProtocol

    init(
        fetchEventsUseCase: FetchEventsUseCaseProtocol,
        placeBetUseCase: PlaceBetUseCaseProtocol
    ) {
        self.fetchEventsUseCase = fetchEventsUseCase
        self.placeBetUseCase    = placeBetUseCase
    }


    var groupedEvents: [(hour: String, events: [BetEvent])] {
        guard case .loaded(let events) = loadState else { return [] }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var dict: [String: [BetEvent]] = [:]
        for event in events {
            let key = formatter.string(from: event.kickoffDate)
            dict[key, default: []].append(event)
        }
        return dict.keys.sorted().map { (hour: $0, events: dict[$0]!) }
    }

    func loadEvents() async {
        guard case .idle = loadState else { return }
        withAnimation { loadState = .loading }
        do {
            let events = try await fetchEventsUseCase.execute()
            withAnimation(.spring(duration: 0.4)) {
                loadState = .loaded(events)
            }
        } catch {
            withAnimation { loadState = .failed(error.localizedDescription) }
        }
    }

    func retry() {
        loadState = .idle
        Task { await loadEvents() }
    }

    func placeBet(on event: BetEvent, selection: BetSelection) async {
        do {
            let bet = try await placeBetUseCase.execute(event: event, selection: selection)
            withAnimation(.spring(duration: 0.3)) {
                confirmedBet = bet
            }
            try? await Task.sleep(for: .seconds(2.5))
            withAnimation { confirmedBet = nil }
        } catch let error as PlaceBetError {
            placeBetError = error.localizedDescription
        } catch {
            placeBetError = error.localizedDescription
        }
    }
    
}
