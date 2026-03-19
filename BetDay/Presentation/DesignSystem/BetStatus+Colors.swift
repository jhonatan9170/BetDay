//
//  BetStatus+Colors.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI

extension BetStatus {
    var color: Color {
        switch self {
        case .pending: return .betPending
        case .won:     return .betWon
        case .lost:    return .betLost
        }
    }
}
