//
//  Ship.swift
//  BattleShips
//
//  Created by Hamish Arro on 12/05/2021.
//

import Foundation

class Ship {
    var name: String!
    var size: Int!
    var direction: Bool?
    var locations: [String] = []
    var hits = 0
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
    
    func hit() -> String {
        self.hits += 1
        return self.hits == size ? "Sunk ship!" : "Hit"
    }
}
