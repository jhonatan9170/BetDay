//
//  BetStatus.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

enum BetStatus: String, Codable, CaseIterable {
    case pending = "PENDING"
    case won     = "WON"
    case lost    = "LOST"
 
    var emoji: String {
        switch self {
        case .pending: return "⏳"
        case .won:     return "✅"
        case .lost:    return "❌"
        }
    }
}
