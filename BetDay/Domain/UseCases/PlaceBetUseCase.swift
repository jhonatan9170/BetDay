//
//  PlaceBetUseCase.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation

protocol PlaceBetUseCaseProtocol: Sendable {
    func execute(event: BetEvent, selection: BetSelection) async throws -> PlacedBet
}

struct PlaceBetUseCase: PlaceBetUseCaseProtocol {

    private let betRepository: BetRepositoryProtocol

    init(betRepository: BetRepositoryProtocol) {
        self.betRepository = betRepository
    }

    func execute(event: BetEvent, selection: BetSelection) async throws -> PlacedBet {
        let existing = try await betRepository.fetchAll()
        if existing.contains(where: { $0.eventId == event.id && $0.status == .pending }) {
            throw PlaceBetError.duplicateBet(eventId: event.id)
        }
        let dto = PlacedBet(
            id: UUID().uuidString,
            eventId: event.id,
            homeTeam: event.homeTeam,
            awayTeam: event.awayTeam,
            leagueName: event.league.name,
            leagueFlag: event.league.flag,
            selection: selection,
            odds: odds(for: selection, in: event),
            status: .pending,
            placedAt: Date()
        )
        try await betRepository.save(bet: dto)
        return dto
    }

    private func odds(for selection: BetSelection, in event: BetEvent) -> Double {
        switch selection {
        case .home: return event.odds.home
        case .draw: return event.odds.draw
        case .away: return event.odds.away
        }
    }
}
