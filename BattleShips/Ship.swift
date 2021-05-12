//
//  Ship.swift
//  BattleShips
//
//  Created by Hamish Arro on 12/05/2021.
//

import Foundation

struct Ship {
    var name: String!
    var size: Int!
    var direction: Bool!
    
    init(name: String, size: Int, direction: Bool) {
        self.name = name
        self.size = size
        self.direction = direction
    }
}
