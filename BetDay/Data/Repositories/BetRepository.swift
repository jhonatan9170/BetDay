//
//  BetRepository.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation
import SwiftData
 
@MainActor
final class SwiftDataBetRepository: BetRepositoryProtocol {
 
    private let modelContext: ModelContext
 
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
 
    func save(bet: PlacedBet) async throws {
        let model = PlacedBetData(from: bet)
        modelContext.insert(model)
        try modelContext.save()
    }
 
    func fetchAll() async throws -> [PlacedBet] {
        let descriptor = FetchDescriptor<PlacedBetData>(
            sortBy: [SortDescriptor(\.placedAt, order: .reverse)]
        )
        let models = try modelContext.fetch(descriptor)
        return models.map(\.toBet)
    }
 
    func update(betId: String, status: BetStatus) async throws {
        let descriptor = FetchDescriptor<PlacedBetData>(
            predicate: #Predicate { $0.id == betId }
        )
        guard let model = try modelContext.fetch(descriptor).first else { return }
        model.betStatus = status
        try modelContext.save()
    }
    
}

 
private extension PlacedBetData {
    convenience init(from bet: PlacedBet) {
        self.init(
            id: bet.id,
            eventId: bet.eventId,
            homeTeam: bet.homeTeam,
            awayTeam: bet.awayTeam,
            leagueName: bet.leagueName,
            leagueFlag: bet.leagueFlag,
            selection: bet.selection,
            odds: bet.odds,
            status: bet.status
        )
    }
 
    var toBet: PlacedBet {
        PlacedBet(
            id: id,
            eventId: eventId,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            leagueName: leagueName,
            leagueFlag: leagueFlag,
            selection: betSelection,
            odds: odds,
            status: betStatus,
            placedAt: placedAt
        )
    }
}
