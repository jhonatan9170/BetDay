//
//  PlacedBetDTO.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation

struct PlacedBet: Identifiable, Sendable {
    let id: String
    let eventId: String
    let homeTeam: String
    let awayTeam: String
    let leagueName: String
    let leagueFlag: String
    let selection: BetSelection
    let odds: Double
    var status: BetStatus
    let placedAt: Date
}
