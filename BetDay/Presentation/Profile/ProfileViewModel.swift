//
//  ProfileViewModel.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class ProfileViewModel {

    var bets: [PlacedBet] = []
    var isLoading = false
    var error: String? = nil

    private let fetchBetsUseCase: FetchBetsUseCaseProtocol
    private let updateBetStatusUseCase: UpdateBetStatusUseCaseProtocol

    init(
        fetchBetsUseCase: FetchBetsUseCaseProtocol,
        updateBetStatusUseCase: UpdateBetStatusUseCaseProtocol
    ) {
        self.fetchBetsUseCase       = fetchBetsUseCase
        self.updateBetStatusUseCase = updateBetStatusUseCase
    }

    func loadBets() async {
        isLoading = true
        defer { isLoading = false }
        do {
            bets = try await fetchBetsUseCase.execute()
        } catch {
            self.error = error.localizedDescription
        }
    }

    func simulateResult(for bet: PlacedBet) async {
        let newStatus: BetStatus = [.won, .lost].randomElement()!
        do {
            try await updateBetStatusUseCase.execute(betId: bet.id, status: newStatus)
            await loadBets()
        } catch {
            self.error = error.localizedDescription
        }
    }
}
