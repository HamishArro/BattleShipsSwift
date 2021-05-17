//
//  main.swift
//  BattleShips
//
//  Created by Hamish Arro on 12/05/2021.
//

import Foundation
var game = BattleShipsGame()
let ships = [Ship(name: "Destroyer", size: 2), Ship(name: "Submarine", size: 3), Ship(name: "Cruiser", size: 3), Ship(name: "Battleship", size: 4), Ship(name: "Carrier", size: 5)]

print("Welcome to battle ships! Please enter your name to begin.")
let name = String(readLine()!)
print("Hello \(name), the rules are as follows.\n\n- Players take turns firing shots to attempt to hit the opponent's enemy ships. \n- On your turn, call out a letter (A - H) and a number (1 - 8) that identifies a row and column on your target grid. \n- You will be altered with a 'Hit' or 'Miss' depending on the outcome of the shot.\n")
while !game.gameOver {
    placeAllShips()
    game.gameOver = true
}

func placeAllShips() {
    for ship in ships {
        print("\(ship.name!)\nSize: \(ship.size!)\n\nFacing north or east?")
        switch String(readLine()!).lowercased() {
        case "north": ship.direction = true
        case "east": ship.direction = false
        default: throw 
        }
        if direction == "north" { ship.direction = true }
    }
}
