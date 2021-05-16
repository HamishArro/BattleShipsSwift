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
    
    func testThrowsErrorWhen8() throws {
        let smallShip = Ship(name: "Dingy", size: 1, direction: true)
        XCTAssertThrowsError(try sut.makeLocation("8B", smallShip))
        XCTAssertThrowsError(try sut.makeLocation("8A", smallShip), "Unable to create location", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? GameError, GameError.locationError)
    })}
    
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
    
    func testCheckOnEmptyGrid() {
        let mediumShip = Ship(name: "Rib", size: 2, direction: true)
        XCTAssertEqual(try sut.checkLocations("1A", mediumShip, []), ["1A", "2A"])
    }
    
    func testPlaceOnTakenSlots() throws {
        var mediumShip = Ship(name: "Rib", size: 2, direction: true)
        mediumShip.locations = ["1A", "2A"]
        let smallShip = Ship(name: "Dingy", size: 1, direction: false)
        XCTAssertThrowsError(try sut.checkLocations("1A", smallShip, [mediumShip]))
        XCTAssertThrowsError(try sut.checkLocations("1A", smallShip, [mediumShip]), "Slot is already in use", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? GameError, GameError.slotTaken)})
    }
    
    func testCheckEdgeNorth() {
        let mediumShip = Ship(name: "Rib", size: 2, direction: true)
        XCTAssertEqual(try sut.checkLocations("7A", mediumShip, []), ["7A", "8A"])
    }
    
    func testCheckEdgeEast() {
        let mediumShip = Ship(name: "Rib", size: 2, direction: false)
        XCTAssertEqual(try sut.checkLocations("1G", mediumShip, []), ["1G", "1H"])
    }

}
