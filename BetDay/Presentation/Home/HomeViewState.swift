//
//  HomeViewState.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 19/03/26.
//

enum HomeViewState: Equatable {
    
    case idle
    case loading
    case loaded([BetEvent])
    case failed(String)

    static func == (lhs: HomeViewState, rhs: HomeViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading): return true
        case (.loaded(let a), .loaded(let b)):     return a.map(\.id) == b.map(\.id)
        case (.failed(let a), .failed(let b)):     return a == b
        default: return false
        }
    }
}
