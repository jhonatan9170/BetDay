//
//  ContentView.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 18/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Today", systemImage: "calendar.day.timeline.left")
                }
            ProfileView()
                .tabItem {
                    Label("My Bets", systemImage: "ticket.fill")
                }
        }
        .tint(.betAccent)
    }
}
 
