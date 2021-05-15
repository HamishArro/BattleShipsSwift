//
//  BattleShipsGame.swift
//  BattleShips
//
//  Created by Hamish Arro on 14/05/2021.
//

import Foundation

class BattleShipsGame {
    var grid: [Int: [Character?]] = [1:[],2:[],3:[],4:[],5:[],6:[],7:[],8:[]]
    
    func placeShip(_ number: Int, _ character: Character, _ ship: Ship) throws {
        var index = number
        var locations: [(num: Int, char: Character)] = []
        for _ in 1...ship.size {
            if grid[index]!.contains(character) {
                throw GameError.slotTaken
            } else {
                locations.append((num: number, char: character))
            }
            index += 1
        }
        for location in locations {
            grid[location.num]!.append(location.char)
        }
    }
    
}

enum GameError : Error {
    case slotTaken
}

extension GameError : LocalizedError {
    var errorDescription: String? {
        switch self {
            case .slotTaken:
                return NSLocalizedString(
                    "Slot is already in use",
                    comment: ""
                )
        }
    }
}
