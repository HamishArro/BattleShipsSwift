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
    var damagedLocation: [String] = []
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
    
    func hit(_ location: String) -> String {
        if let index = locations.firstIndex(of: location) {
            locations.remove(at: index)
            damagedLocation.append(location)
        }
        return locations.isEmpty ? "Sunk ship!" : "Hit"
    }
}
