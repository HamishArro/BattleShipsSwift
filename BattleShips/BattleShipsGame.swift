//
//  BattleShipsGame.swift
//  BattleShips
//
//  Created by Hamish Arro on 14/05/2021.
//

import Foundation

class BattleShipsGame {
    var playerOneGrid: [Ship] = []
    var playerTwoGrid: [Ship] = []
    var gameOver = false
    
    func placeShip(_ location: String, _ ship: inout Ship, _ grid: inout [Ship]) throws {
        ship.locations = try checkLocations(location, ship, grid)
        grid.append(ship)
    }
    
    func checkLocations(_ location: String, _ pendingShip: Ship, _ grid: [Ship]) throws -> [String] {
        var location = location
        var locations: [String] = []
        var place = true
        for iteration in 1...pendingShip.size {
            for ship in grid { if ship.locations.contains(location) { place = false } }
            locations.append(location)
            if iteration != pendingShip.size { location = try makeLocation(location, pendingShip) }
        }
        if place { return locations } else { throw GameError.slotTaken }
    }
    
    func makeLocation(_ location: String, _ ship: Ship) throws -> String {
        let components = Array(location).map { String($0) }
        let letterSet = ["A", "B", "C", "D", "E", "F", "G", "H"]
        if ship.direction! {
            if Int(components[0])! != 8 { return String(Int(components[0])! + 1) + components[1] }
            else { throw GameError.locationError }
        } else {
            for (index, letter) in letterSet.enumerated() { if letter == components[1] && index != letterSet.count - 1 {
                return components[0] + letterSet[index + 1]
            } }
        }
        throw GameError.locationError
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
