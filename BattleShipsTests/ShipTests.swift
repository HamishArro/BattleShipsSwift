//
//  BattleShipsTests.swift
//  BattleShipsTests
//
//  Created by Hamish Arro on 12/05/2021.
//

import XCTest
@testable import BattleShips

class ShipTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShip() {
        let smallShip = Ship(name: "Dingy", size: 1, direction: true)
        XCTAssertEqual(smallShip.name, "Dingy")
        XCTAssertEqual(smallShip.size, 1)
        XCTAssertEqual(smallShip.direction, true)
    }

}
