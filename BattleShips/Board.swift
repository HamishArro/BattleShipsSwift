//
//  BattleShipsGame.swift
//  BattleShips
//
//  Created by Hamish Arro on 14/05/2021.
//
let LetterSet = ["A", "B", "C", "D", "E", "F", "G", "H"]
import Foundation

class Board {
    var grid: [Ship] = []
    var fireLog: [String: String] = [:]
    var gameOver = false
    
    func fire(_ location: String) throws -> String {
        var output = "Miss"
        let location = try validateLocation(location.uppercased())
        if fireLog[location] != nil { throw BattleShipsError.alreadyFiredHere }
        for (index, ship) in grid.enumerated() { if ship.locations.contains(location) {
            output = ship.hit(location)
            if output == "Sunk ship!" { grid.remove(at: index) }
        } }
        fireLog[location] = output
        if grid.isEmpty { gameOver = true }
        return output
    }
    
    func validateLocation(_ location: String ) throws -> String {
        let components = Array(location).map { String($0) }
        if components.count != 2 { throw BattleShipsError.locationError }
        guard let number = Int(components[0]) else { throw BattleShipsError.locationError }
        let letter = components[1]
        if (number >= 1 && number <= 8) && LetterSet.contains(letter) { return location }
        else {throw BattleShipsError.locationError }
    }
    
    func placeShip(_ location: String, _ ship: inout Ship) throws {
        ship.locations = try checkLocations(location, ship)
        grid.append(ship)
    }
    
    func checkLocations(_ location: String, _ pendingShip: Ship) throws -> [String] {
        var location = try validateLocation(location.uppercased())
        var locations: [String] = []
        var place = true
        for iteration in 1...pendingShip.size {
            for ship in grid { if ship.locations.contains(location) { place = false } }
            locations.append(location)
            if iteration != pendingShip.size { location = try makeLocation(location, pendingShip) }
        }
        if place { return locations } else { throw BattleShipsError.slotTaken }
    }
    
    func makeLocation(_ location: String, _ ship: Ship) throws -> String {
        let components = Array(location).map { String($0) }
        if ship.direction! { if Int(components[0])! != 8 { return String(Int(components[0])! + 1) + components[1] } else { throw BattleShipsError.locationError }
        } else { for (index, letter) in LetterSet.enumerated() { if letter == components[1] && index != LetterSet.count - 1 { return components[0] + LetterSet[index + 1]} }
        }
        throw BattleShipsError.locationError
    }
    
}

enum BattleShipsError : Error {
    case slotTaken
    case locationError
    case alreadyFiredHere
}
