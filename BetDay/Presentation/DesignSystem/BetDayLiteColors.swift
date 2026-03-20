//
//  BetDayLiteColors.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

import SwiftUI

enum BetColors {
    static let background    = Color("Background")
    static let surface       = Color("Surface")
    static let surfaceAlt    = Color("SurfaceAlt")
    static let accent        = Color("Accent")
    static let accentWarm    = Color("AccentWarm")
    static let textPrimary   = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let won           = Color("Won")
    static let lost          = Color("Lost")
    static let pending       = Color("Pending")
}
 
 
extension Color {
    static let betBackground    = Color(hex: "#FFFFFF") 
    static let betSurface       = Color(hex: "#F5F6F8")
    static let betSurfaceAlt    = Color(hex: "#E9EAED")
    static let betAccent        = Color(hex: "#43A047")
    static let betAccentWarm    = Color(hex: "#F5A623")
    static let betTextPrimary   = Color(hex: "#17191C")
    static let betTextSecondary = Color(hex: "#797D86")
    static let betWon           = Color(hex: "#34D399")
    static let betLost          = Color(hex: "#F87171")
    static let betPending       = Color(hex: "#FBBF24")
 
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
