//
//  BetEvent.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation

struct BetEvent: Identifiable {
    let id: String
    let league: League
    let homeTeam: String
    let awayTeam: String
    let kickoffDate: Date
    let odds: Odds
}
 
struct League {
    let name: String
    let flag: String
}
 
struct Odds {
    let home: Double
    let draw: Double
    let away: Double
}
