//
//  EndPoint.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import Foundation

enum Endpoint {
    case todaysEvents
 
    private var baseURL: URL {
        URL(string: "https://05d0a0f6-fc0b-4105-96f7-748e7a92e611.mock.pstmn.io")!
    }
 
    var urlRequest: () throws -> URLRequest {
        {
            var components: URLComponents
 
            switch self {
            case .todaysEvents:
                components = URLComponents(
                    url: baseURL.appendingPathComponent("/configs"),
                    resolvingAgainstBaseURL: false
                )!
            }
 
            guard let url = components.url else {
                throw APIError.malformedURL
            }
 
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }
    }
}
