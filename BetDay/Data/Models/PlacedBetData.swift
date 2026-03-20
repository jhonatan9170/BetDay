//
//  BetRepositoryData.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import Foundation
import SwiftData

@Model
final class PlacedBetData {
    @Attribute(.unique) var id: String
    var eventId: String
    var homeTeam: String
    var awayTeam: String
    var leagueName: String
    var leagueFlag: String
    var selection: String       
    var odds: Double
    var statusRaw: String
    var placedAt: Date

    init(
        id: String = UUID().uuidString,
        eventId: String,
        homeTeam: String,
        awayTeam: String,
        leagueName: String,
        leagueFlag: String,
        selection: BetSelection,
        odds: Double,
        status: BetStatus = .pending
    ) {
        self.id = id
        self.eventId = eventId
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.leagueName = leagueName
        self.leagueFlag = leagueFlag
        self.selection = selection.rawValue
        self.odds = odds
        self.statusRaw = status.rawValue
        self.placedAt = Date()
    }

    var betSelection: BetSelection {
        BetSelection(rawValue: selection) ?? .home
    }

    var betStatus: BetStatus {
        get { BetStatus(rawValue: statusRaw) ?? .pending }
        set { statusRaw = newValue.rawValue }
    }
}

