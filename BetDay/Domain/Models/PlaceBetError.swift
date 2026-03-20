//
//  PlaceBetError.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation

enum PlaceBetError: LocalizedError {
    case duplicateBet(eventId: String)

    var errorDescription: String? {
        switch self {
        case .duplicateBet:
            return "You already have an active bet on this match."
        }
    }
}
