//
//  Game.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func successfulMissle()
}

class Game {
    // 0 - Water
    // 1 - Miss
    // 2 - Hit ship
    // 3 - Sunk ship
    // 4 - Ship
    private var _playerOneGameBoard: Array<Array<Int>>
    private var _playerTwoGameBoard: Array<Array<Int>>
    private var _playersTurn: Int
    private var _gameStatusMessage: String
    
    private var _playerOneCarrier = Array<Point>()
    private var _playerOneBattleship = Array<Point>()
    private var _playerOneSubmarine = Array<Point>()
    private var _playerOneDestroyer = Array<Point>()
    private var _playerOnePatrolBoat = Array<Point>()
    
    private var _playerTwoCarrier = Array<Point>()
    private var _playerTwoBattleship = Array<Point>()
    private var _playerTwoSubmarine = Array<Point>()
    private var _playerTwoDestroyer = Array<Point>()
    private var _playerTwoPatrolBoat = Array<Point>()
    
    private var _playerOneCarrierHits = 0
    private var _playerOneBattleshipHits = 0
    private var _playerOneSubmarineHits = 0
    private var _playerOneDestroyerHits = 0
    private var _playerOnePatrolBoatHits = 0
    
    private var _playerTwoCarrierHits = 0
    private var _playerTwoBattleshipHits = 0
    private var _playerTwoSubmarineHits = 0
    private var _playerTwoDestroyerHits = 0
    private var _playerTwoPatrolBoatHits = 0
    
    var playersTurn: Int {
        get { return _playersTurn }
        set { _playersTurn = newValue }
    }
    
    var gameStatusMessage: String {
        get { return _gameStatusMessage }
        set { _gameStatusMessage = newValue }
    }
    
    var playerOneGameBoard: Array<Array<Int>> {
        get { return _playerOneGameBoard }
    }
        
    var playerTwoGameBoard: Array<Array<Int>> {
        get { return _playerTwoGameBoard }
    }
    
     weak var delegate: GameDelegate? = nil
    
    init () {
        _playersTurn = 1
        _playerOneGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
        _playerTwoGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
        _gameStatusMessage = "Player One's Turn"
        placeShips()
    }
    
    // 0 - Water
    // 1 - Miss
    // 2 - Hit ship
    // 3 - Sunk ship
    // 4 - Ship
    func fireMissle(row: Int, column: Int) {
        
        if (playersTurn == 1) {
            let hitCellValueTwo: Int = _playerTwoGameBoard[row][column]
            if (hitCellValueTwo == 0) {
                _playerTwoGameBoard[row][column] = 1
                gameStatusMessage = "Miss!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                delegate?.successfulMissle()
                //changeTurns()
            }
            else if (hitCellValueTwo == 4) {
                _playerTwoGameBoard[row][column] = 2
                gameStatusMessage = "Hit!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                delegate?.successfulMissle()
               // changeTurns()
            }
        }
        else {
            let hitCellValueOne: Int = _playerOneGameBoard[row][column]
            if (hitCellValueOne == 0) {
                _playerOneGameBoard[row][column] = 1
                gameStatusMessage = "Miss!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                delegate?.successfulMissle()
               // changeTurns()
            }
            else if (hitCellValueOne == 4) {
                _playerOneGameBoard[row][column] = 2
                gameStatusMessage = "Hit!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                delegate?.successfulMissle()
               // changeTurns()
            }
            
        }
    }
    
    func changeTurns() {
        if (_playersTurn == 1) {
            _playersTurn = 2
        }
        else {
            _playersTurn = 1
        }
    }
    
    func checkForSunkShips() {
        if (_playerOneCarrierHits == 5) {
            for point in _playerOneCarrier {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            gameStatusMessage = "Carrier Sunk!"
        }
        else if (_playerOnePatrolBoatHits == 2) {
            for point in _playerOnePatrolBoat {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            _playerOnePatrolBoatHits = 0
            gameStatusMessage = "Patrol Boat Sunk!"
        }
        
    }
    
    func addHitPoint(row: Int, column: Int) {
        for point in _playerOneCarrier {
            if (point.row == row && point.column == column && !point.marked) {
                _playerOneCarrierHits++;
                point
                return;
            }
        }
        for var i = 0; i < _playerOnePatrolBoat.count; i++ {
            if (_playerOnePatrolBoat[i].row == row && _playerOnePatrolBoat[i].column == column && !_playerOnePatrolBoat[i].marked) {
                _playerOnePatrolBoatHits++;
                _playerOnePatrolBoat[i].marked = true
                return;
            }
        }
        
    }
    
    func placeShips() {
        var playerOneCarrierPlaced = false
        var playerOneBattleshipPlaced = false
        var placeOneSubmarinePlaced = false
        var playerOneDestroyerPlaced = false
        var playerOnePatrolBoatPlaced = false
        
        var playerTwoCarrierPlaced = false
        var playerTwoBattleshipPlaced = false
        var playerTwoSubmarinePlaced = false
        var playerTwoDestroyerPlaced = false
        var playerTwoPatrolBoatPlaced = false
        
        var rowSelector: Int = 0
        var colSelector: Int = 0
        var rowOrColSelector: Int = 0
        
        while (!playerOnePatrolBoatPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            rowSelector = Int(arc4random_uniform(UInt32(9)))
            colSelector = Int(arc4random_uniform(UInt32(9)))
            if (rowOrColSelector == 0) {
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    playerOnePatrolBoatPlaced = true
                }
            } else {
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOnePatrolBoat.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    playerOnePatrolBoatPlaced = true
                }
            }
        }
        
        while (!playerTwoPatrolBoatPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            rowSelector = Int(arc4random_uniform(UInt32(9)))
            colSelector = Int(arc4random_uniform(UInt32(9)))
            if (rowOrColSelector == 0) {
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    playerTwoPatrolBoatPlaced = true
                }
            } else {
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoPatrolBoat.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    playerTwoPatrolBoatPlaced = true
                }
            }
        }
    }
}

struct Point {
    var row: Int
    var column: Int
    var marked: DarwinBoolean
}
