//
//  FetchBetsUseCase.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

protocol FetchBetsUseCaseProtocol: Sendable {
    func execute() async throws -> [PlacedBet]
}
 
struct FetchBetsUseCase: FetchBetsUseCaseProtocol {
 
    private let repository: BetRepositoryProtocol
 
    init(repository: BetRepositoryProtocol) {
        self.repository = repository
    }
 
    func execute() async throws -> [PlacedBet] {
        try await repository.fetchAll()
    }
}
 
