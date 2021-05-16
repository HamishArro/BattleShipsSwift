//
//  BattleShipGameTests.swift
//  BattleShipsTests
//
//  Created by Hamish Arro on 14/05/2021.
//

import XCTest
@testable import BattleShips

class BattleShipsGameTests: XCTestCase {
    var sut: BattleShipsGame!
    
    override func setUpWithError() throws {
        sut = BattleShipsGame()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMakeLocationWhenNorth() {
        let smallShip = Ship(name: "Dingy", size: 1, direction: true)
        XCTAssertEqual(try sut.makeLocation("2A", smallShip), "3A")
    }
    
    func testMakeLocationWhenEast() {
        let smallShip = Ship(name: "Dingy", size: 1, direction: false)
        XCTAssertEqual(try sut.makeLocation("2A", smallShip), "2B")
        XCTAssertEqual(try sut.makeLocation("2G", smallShip), "2H")
    }
    
    func testThrowsErrorWhenH() throws {
        let smallShip = Ship(name: "Dingy", size: 1, direction: false)
        XCTAssertThrowsError(try sut.makeLocation("2H", smallShip))
        XCTAssertThrowsError(try sut.makeLocation("3H", smallShip), "Unable to create location", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? GameError, GameError.locationError)
    })}

}
