//
//  BattleShipsTests.swift
//  BattleShipsTests
//
//  Created by Hamish Arro on 12/05/2021.
//

import XCTest
@testable import BattleShips

class ShipTests: XCTestCase {

    func testShip() {
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = true
        XCTAssertEqual(smallShip.name, "Dingy")
        XCTAssertEqual(smallShip.size, 1)
        XCTAssertEqual(smallShip.direction, true)
    }

}
