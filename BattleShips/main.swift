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

//placeAllShips()
computerChoice()
for ship in game.playerTwoGrid {
    print(ship.locations)
}
playGame()

func playGame() {
    while !game.gameOver {
        print("Where would you like to fire?")
        getUserChoice()
        try getComputerChoice()
    }
}

func getComputerChoice() throws {
    let result = try game.fire(randomLocation(), &game.playerOneGrid)
    print("Enemy \(result)")
}

func getUserChoice() {
    do { print(try game.fire(String(readLine()!), &game.playerTwoGrid))
    } catch {
        print("Invaild location, enter again.")
        getUserChoice()
    }
}

func computerChoice() {
    for (index, ship) in computerShips.enumerated() {
        computerPlace(ship, index)
    }
}

func computerPlace(_ ship: Ship, _ index: Int) {
    do {
        ship.direction = Bool.random()
        try game.placeShip(randomLocation(), &computerShips[index], &game.playerTwoGrid)
    } catch { computerPlace(ship, index) }
}

func randomLocation() -> String {
    return String(Int.random(in: 1...8)) + String(game.letterSet.randomElement()!)
}

func placeAllShips() {
    for (index, ship) in ships.enumerated() {
        print("\(ship.name!)\nSize: \(ship.size!)\n\nWhere should it face, north or east?")
        getDriection(ship)
        print("Where do you want to put it?")
        doPlace(index)
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

func doPlace(_ index: Int) {
    do { try game.placeShip(String(readLine()!), &ships[index], &game.playerOneGrid)
    } catch BattleShipsError.slotTaken {
        print("Cannot place in slot that is in use, enter again.")
        doPlace(index)
    } catch BattleShipsError.locationError { print("Ship goes over the allowed boundary, enter again.")
        doPlace(index)
    } catch { print("Error. Try again.")
        doPlace(index)
    }
}
