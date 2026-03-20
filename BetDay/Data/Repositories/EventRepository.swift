//
//  EventRepository.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation

struct EventRepository: EventRepositoryProtocol {

    private let dataSource: RemoteEventDataSourceProtocol

    init(dataSource: RemoteEventDataSourceProtocol = RemoteEventDataSource()) {
        self.dataSource = dataSource
    }

    func fetchTodaysEvents() async throws -> [BetEvent] {
        try await dataSource.fetchEvents()
    }
    
}
