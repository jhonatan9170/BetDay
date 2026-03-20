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
        let specialCases: [String: String] = [
            "England": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
            "Europe": "🏆"
        ]
        if let flag = specialCases[country] {
            return flag
        }
        
        if let code = Locale.isoRegionCodes.first(where: {
            Locale.current.localizedString(forRegionCode: $0)?.lowercased() == country.lowercased()
        }) {
            let base: UInt32 = 127397
            let scalars = code.uppercased().unicodeScalars.compactMap {
                UnicodeScalar(base + $0.value)
            }
            return String(String.UnicodeScalarView(scalars))
        }
        return "🌍"
    }
    
}

extension OddsResponse {
    var toDomain: Odds {
        Odds(home: home, draw: draw, away: away)
    }
}
