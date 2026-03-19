//
//  BetSelection.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

enum BetSelection: String, Codable, CaseIterable {
    case home = "1"
    case draw = "X"
    case away = "2"
 
    var label: String { rawValue }
    var fullLabel: String {
        switch self {
        case .home: return "Home Win"
        case .draw: return "Draw"
        case .away: return "Away Win"
        }
    }
}
