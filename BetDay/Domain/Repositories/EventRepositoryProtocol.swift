//
//  EventRepositoryProtocol.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

protocol EventRepositoryProtocol: Sendable {
    func fetchTodaysEvents() async throws -> [BetEvent]
}
