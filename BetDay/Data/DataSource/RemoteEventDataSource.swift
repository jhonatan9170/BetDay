//
//  RemoteEventDataSource.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import Foundation

protocol RemoteEventDataSourceProtocol: Sendable {
    func fetchEvents() async throws -> [BetEvent]
}

struct RemoteEventDataSource: RemoteEventDataSourceProtocol {
 
    private let session: URLSession
    private let decoder: JSONDecoder
 
    init(session: URLSession = .shared) {
        self.session = session
 
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }
 
    func fetchEvents() async throws -> [BetEvent] {
        let request = try Endpoint.todaysEvents.urlRequest()
        let (data, response) = try await session.data(for: request)
        try validate(response)
        let apiResponse = try decoder.decode(MatchesResponse.self, from: data)
        return apiResponse.matches.map(\.toDomain)
    }
  
    private func validate(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200...299).contains(http.statusCode) else {
            throw APIError.httpError(statusCode: http.statusCode)
        }
    }
}
