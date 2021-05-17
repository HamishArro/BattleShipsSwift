//
//  main.swift
//  BattleShips
//
//  Created by Hamish Arro on 12/05/2021.
//

import Foundation
var game = BattleShipsGame()
var ships = [Ship(name: "Destroyer", size: 2), Ship(name: "Submarine", size: 3), Ship(name: "Cruiser", size: 3), Ship(name: "Battleship", size: 4), Ship(name: "Carrier", size: 5)]
var computerShips = [Ship(name: "Destroyer", size: 2), Ship(name: "Submarine", size: 3), Ship(name: "Cruiser", size: 3), Ship(name: "Battleship", size: 4), Ship(name: "Carrier", size: 5)]

print("Welcome to battle ships! Please enter your name to begin.")
let name = String(readLine()!)
print("Hello \(name), the rules are as follows.\n\n- Players take turns firing shots to attempt to hit the opponent's enemy ships. \n- On your turn, call out a number (1 - 8) and a letter (A - H) that identifies a row and column on your target grid. \n- You will be altered with a 'Hit' or 'Miss' depending on the outcome of the shot.\n")

try placeAllShips()
computerChoice()


func computerChoice() {
    for (index, ship) in computerShips.enumerated() {
        randomPlace(ship, index)
    }
}

func randomPlace(_ ship: Ship, _ index: Int) {
    do {
        ship.direction = Bool.random()
        try game.placeShip(String(Int.random(in: 1...8)) + String(game.letterSet.randomElement()!), &computerShips[index], &game.playerTwoGrid)
    } catch { randomPlace(ship, index) }
}

func placeAllShips() throws {
    for (index, ship) in ships.enumerated() {
        print("\(ship.name!)\nSize: \(ship.size!)\n\nWhere should it face, north or east?")
        getDriection(ship)
        print("Where do you want to put it?")
        try doPlace(index)
    }
}

func getDriection(_ ship: Ship) {
    switch String(readLine()!).lowercased() {
    case "north": ship.direction = true
    case "east": ship.direction = false
    default: print("Inncorrect Input, enter again.")
        getDriection(ship)
    }
}

func doPlace(_ index: Int) throws {
    do { try game.placeShip(String(readLine()!), &ships[index], &game.playerOneGrid)
    } catch BattleShipsError.slotTaken {
        print("Cannot place in slot that is in use, enter again.")
        try doPlace(index)
    } catch BattleShipsError.locationError {
        print("Ship goes over the allowed boundary, enter again.")
        try doPlace(index)
    } catch { throw GameError.doPlaceError }
}

enum GameError: Error {
    case doPlaceError
}
