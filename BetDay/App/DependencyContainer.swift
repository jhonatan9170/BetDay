//
//  DependencyContainer.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//
import Foundation
import SwiftData

@MainActor
final class DependencyContainer {

    static var shared: DependencyContainer!

    private let betRepository: BetRepositoryProtocol
    private let eventRepository: EventRepositoryProtocol

    let fetchEventsUseCase: FetchEventsUseCaseProtocol
    let placeBetUseCase: PlaceBetUseCaseProtocol
    let fetchBetsUseCase: FetchBetsUseCaseProtocol
    let updateBetStatusUseCase: UpdateBetStatusUseCaseProtocol

    init(modelContext: ModelContext) {
        self.betRepository   = SwiftDataBetRepository(modelContext: modelContext)
        self.eventRepository = EventRepository()
        self.fetchEventsUseCase    = FetchEventsUseCase(repository: eventRepository)
        self.placeBetUseCase       = PlaceBetUseCase(betRepository: betRepository)
        self.fetchBetsUseCase      = FetchBetsUseCase(repository: betRepository)
        self.updateBetStatusUseCase = UpdateBetStatusUseCase(repository: betRepository)
    }
    
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            fetchBetsUseCase: fetchBetsUseCase,
            updateBetStatusUseCase: updateBetStatusUseCase
        )
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            fetchEventsUseCase: fetchEventsUseCase,
            placeBetUseCase: placeBetUseCase
        )
    }

}
