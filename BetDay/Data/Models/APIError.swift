//
//  APIError.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import Foundation

enum APIError: LocalizedError {
    case malformedURL
    case invalidResponse
    case httpError(statusCode: Int)
 
    var errorDescription: String? {
        switch self {
        case .malformedURL:
            return "The request URL could not be constructed."
        case .invalidResponse:
            return "The server returned an unexpected response."
        case .httpError(let code):
            return "Request failed with status code \(code)."
        }
    }
}
