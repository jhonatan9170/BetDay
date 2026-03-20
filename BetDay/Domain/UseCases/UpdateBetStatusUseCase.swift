//
//  UpdateBetStatusUseCase.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

protocol UpdateBetStatusUseCaseProtocol: Sendable {
    func execute(betId: String, status: BetStatus) async throws
}
 
struct UpdateBetStatusUseCase: UpdateBetStatusUseCaseProtocol {
 
    private let repository: BetRepositoryProtocol
 
    init(repository: BetRepositoryProtocol) {
        self.repository = repository
    }
 
    func execute(betId: String, status: BetStatus) async throws {
        try await repository.update(betId: betId, status: status)
    }
}
 
