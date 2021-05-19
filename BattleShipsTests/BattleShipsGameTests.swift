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
    
    func testGameOver() throws {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.locations = ["1A", "2A"]
        sut.playerTwoGrid = [mediumShip]
        try sut.fire("1A", &sut.playerTwoGrid)
        try sut.fire("2A", &sut.playerTwoGrid)
        XCTAssertTrue(sut.gameOver)
    }
    
    func testValidateLocation() {
        XCTAssertEqual(try sut.validateLocation("1A"), "1A")
    }
    
    func testValidateLocationError() {
        XCTAssertThrowsError(try sut.validateLocation("21"))
        XCTAssertThrowsError(try sut.validateLocation("2"))
        XCTAssertThrowsError(try sut.validateLocation("asds"), "Invaild location", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? BattleShipsError, BattleShipsError.locationError)
        })}
    
    func testFireHit() {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.locations = ["1A", "2A"]
        sut.playerTwoGrid = [mediumShip]
        XCTAssertEqual(try sut.fire("1A", &sut.playerTwoGrid), "Hit")
    }
    
    func testFireSink() throws {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.locations = ["1A", "2A"]
        sut.playerTwoGrid = [mediumShip]
        try sut.fire("1A", &sut.playerTwoGrid)
        XCTAssertEqual(try sut.fire("2A", &sut.playerTwoGrid), "Sunk ship!")
    }
    
    func testFireMiss() {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.locations = ["1A", "2A"]
        sut.playerTwoGrid = [mediumShip]
        XCTAssertEqual(try sut.fire("3A", &sut.playerTwoGrid), "Miss")
    }
    
    func testMakeLocationWhenNorth() {
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = true
        XCTAssertEqual(try sut.makeLocation("2A", smallShip), "3A")
    }
    
    func testThrowsErrorWhen8() throws {
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = true
        XCTAssertThrowsError(try sut.makeLocation("8B", smallShip))
        XCTAssertThrowsError(try sut.makeLocation("8A", smallShip), "Unable to create location", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? BattleShipsError, BattleShipsError.locationError)
    })}
    
    func testMakeLocationWhenEast() {
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = false
        XCTAssertEqual(try sut.makeLocation("2A", smallShip), "2B")
        XCTAssertEqual(try sut.makeLocation("2G", smallShip), "2H")
    }
    
    func testThrowsErrorWhenH() throws {
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = false
        XCTAssertThrowsError(try sut.makeLocation("2H", smallShip))
        XCTAssertThrowsError(try sut.makeLocation("3H", smallShip), "Unable to create location", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? BattleShipsError, BattleShipsError.locationError)
    })}
    
    func testCheckOnEmptyGrid() {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.direction = true
        XCTAssertEqual(try sut.checkLocations("1A", mediumShip, []), ["1A", "2A"])
    }
    
    func testPlaceOnTakenSlots() throws {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.locations = ["1A", "2A"]
        let smallShip = Ship(name: "Dingy", size: 1)
        smallShip.direction = false
        XCTAssertThrowsError(try sut.checkLocations("1A", smallShip, [mediumShip]))
        XCTAssertThrowsError(try sut.checkLocations("1A", smallShip, [mediumShip]), "Slot is already in use", { (errorThrown) in
                                XCTAssertEqual(errorThrown as? BattleShipsError, BattleShipsError.slotTaken)})
    }
    
    func testCheckEdgeNorth() {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.direction = true
        XCTAssertEqual(try sut.checkLocations("7A", mediumShip, []), ["7A", "8A"])
    }
    
    func testCheckEdgeEast() {
        let mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.direction = false
        XCTAssertEqual(try sut.checkLocations("1G", mediumShip, []), ["1G", "1H"])
    }
    
    func testPlaceShip() throws {
        var mediumShip = Ship(name: "Rib", size: 2)
        mediumShip.direction = true
        try sut.placeShip("1A", &mediumShip, &sut.playerTwoGrid)
        XCTAssertEqual(sut.playerTwoGrid[0].name, mediumShip.name)
        XCTAssertEqual(sut.playerTwoGrid[0].locations, ["1A","2A"])
    }

}
