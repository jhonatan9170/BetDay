//
//  BetRepositoryProtocol.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

protocol BetRepositoryProtocol: Sendable {
    func save(bet: PlacedBet) async throws
    func fetchAll() async throws -> [PlacedBet]
    func update(betId: String, status: BetStatus) async throws
}

