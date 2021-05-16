//
//  BattleShipsGame.swift
//  BattleShips
//
//  Created by Hamish Arro on 14/05/2021.
//

import Foundation

class BattleShipsGame {
    var playerOneGrid: [Ship] = []
    
    func placeShip(_ location: String, _ ship: Ship, _ grid: [Ship]) throws {
//        var ship.locations = try checkLocation(location, ship, grid)
    }
    
    func checkLocation(_ location: String, _ pendingShip: Ship, _ grid: [Ship]) throws -> [String] {
        var location = location
        var locations: [String] = []
        var place = true
        for _ in 1...pendingShip.size {
            for ship in grid { if ship.locations.contains(location) { place = false } }
            locations.append(location)
            location = try makeLocation(location, pendingShip)
        }
        if place { return locations } else { throw GameError.slotTaken }
    }
    
    func makeLocation(_ location: String, _ ship: Ship) throws -> String {
        let components = Array(location).map { String($0) }
        if ship.direction { return String(Int(components[0])! + 1) + components[1] } else { throw GameError.locationError }
    }
    
}

enum GameError : Error {
    case slotTaken
    case locationError
}

extension GameError : LocalizedError {
    var errorDescription: String? {
        switch self {
            case .slotTaken:
                return NSLocalizedString("Slot is already in use", comment: "")
            case .locationError:
                return NSLocalizedString("Unable to create location", comment: "")
        }
    }
}
