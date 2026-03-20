//
//  FetchEventsUseCase.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

protocol FetchEventsUseCaseProtocol: Sendable {
    func execute() async throws -> [BetEvent]
}

struct FetchEventsUseCase: FetchEventsUseCaseProtocol {

    private let repository: EventRepositoryProtocol

    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [BetEvent] {
        try await repository.fetchTodaysEvents()
    }
}
