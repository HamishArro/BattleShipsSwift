//
//  main.swift
//  BattleShips
//
//  Created by Hamish Arro on 12/05/2021.
//

import Foundation

print("Welcome to battle ships! Please enter your name to begin.")
let name = readLine()
print("Hello \(String(name!)), the rules are as follows.\n\n- Players take turns firing shots to attempt to hit the opponent's enemy ships. \n- On your turn, call out a letter and a number that identifies a row and column on your target grid. \n- You will be altered with a 'Hit' or 'Miss' depending on the outcome of the shot.")
