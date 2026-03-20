//
//  MatchResponse.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 20/03/26.
//

import Foundation

struct MatchesResponse: Codable {
    let date, timezone: String
    let matches: [Match]
}

struct Match: Codable {
    let id: String
    let startTime: Date
    let league: LeagueResponse
    let homeTeam, awayTeam: Team
    let market: Market
}

struct Team: Codable {
    let id, name, shortName: String
}

struct LeagueResponse: Codable {
    let id: String
    let name: String
    let country: String
}

struct Market: Codable {
    let type: String
    let odds: OddsResponse
}

struct OddsResponse: Codable {
    let home, draw, away: Double
}


extension Match {
    var toDomain: BetEvent {
        BetEvent(
            id: id,
            league: league.toDomain,
            homeTeam: homeTeam.name,
            awayTeam: awayTeam.name,
            kickoffDate: startTime,
            odds: market.odds.toDomain
        )
    }
}

extension LeagueResponse {
    
    var toDomain: League {
        League(
            name: name,
            flag: countryFlag(for: country)
        )
    }
    
    func countryFlag(for country: String) -> String {
        let flags: [String: String] = [
            "England":  "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
            "Spain":    "🇪🇸",
            "Germany":  "🇩🇪",
            "Italy":    "🇮🇹",
            "France":   "🇫🇷",
            "Portugal": "🇵🇹",
            "Turkey":   "🇹🇷",
            "Europe":   "🏆",
        ]
        return flags[country] ?? "🌍"
    }
    
}

extension OddsResponse {
    var toDomain: Odds {
        Odds(home: home, draw: draw, away: away)
    }
}
