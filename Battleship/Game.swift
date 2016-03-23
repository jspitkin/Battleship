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
    
    private var _playerOneSunkShips = 0
    private var _playerTwoSunkShips = 0
    
    var gameOver = false
    
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
            }
            else if (hitCellValueTwo == 4) {
                _playerTwoGameBoard[row][column] = 2
                gameStatusMessage = "Hit!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                checkForVictory()
                delegate?.successfulMissle()
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
            }
            else if (hitCellValueOne == 4) {
                _playerOneGameBoard[row][column] = 2
                gameStatusMessage = "Hit!"
                addHitPoint(row, column: column)
                checkForSunkShips()
                checkForVictory()
                delegate?.successfulMissle()
            }
            
        }
    }
    
    func checkForVictory() {
        if (_playerOneSunkShips == 5) {
            gameStatusMessage = "Player Two Wins!"
            gameOver = true
        }
        if (_playerTwoSunkShips == 5) {
            gameStatusMessage = "Player One Wins!"
            gameOver = true
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
            _playerOneSunkShips++;
            _playerOneCarrierHits = 0
            gameStatusMessage = "Carrier Sunk!"
        }
        else if (_playerOneBattleshipHits == 4) {
            for point in _playerOneBattleship {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            _playerOneBattleshipHits = 0
            _playerOneSunkShips++;
            gameStatusMessage = "Battleship Sunk!"
        }
        else if (_playerOneSubmarineHits == 3) {
            for point in _playerOneSubmarine {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            _playerOneSubmarineHits = 0
            _playerOneSunkShips++;
            gameStatusMessage = "Submarine Sunk!"
        }
        else if (_playerOneDestroyerHits == 3) {
            for point in _playerOneDestroyer {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            _playerOneDestroyerHits = 0
            _playerOneSunkShips++;
            gameStatusMessage = "Destroyer Sunk!"
        }
        else if (_playerOnePatrolBoatHits == 2) {
            for point in _playerOnePatrolBoat {
                _playerOneGameBoard[point.row][point.column] = 3
            }
            _playerOnePatrolBoatHits = 0
            _playerOneSunkShips++;
            gameStatusMessage = "Patrol Boat Sunk!"
        }
        if (_playerTwoCarrierHits == 5) {
            for point in _playerTwoCarrier {
                _playerTwoGameBoard[point.row][point.column] = 3
            }
            _playerTwoSunkShips++;
            _playerTwoCarrierHits = 0
            gameStatusMessage = "Carrier Sunk!"
        }
        else if (_playerTwoBattleshipHits == 4) {
            for point in _playerTwoBattleship {
                _playerTwoGameBoard[point.row][point.column] = 3
            }
            _playerTwoBattleshipHits = 0
            _playerTwoSunkShips++;
            gameStatusMessage = "Battleship Sunk!"
        }
        else if (_playerTwoSubmarineHits == 3) {
            for point in _playerTwoSubmarine {
                _playerTwoGameBoard[point.row][point.column] = 3
            }
            _playerTwoSubmarineHits = 0
            _playerTwoSunkShips++;
            gameStatusMessage = "Submarine Sunk!"
        }
        else if (_playerTwoDestroyerHits == 3) {
            for point in _playerTwoDestroyer {
                _playerTwoGameBoard[point.row][point.column] = 3
            }
            _playerTwoDestroyerHits = 0
            _playerTwoSunkShips++;
            gameStatusMessage = "Destroyer Sunk!"
        }
        else if (_playerTwoPatrolBoatHits == 2) {
            for point in _playerTwoPatrolBoat {
                _playerTwoGameBoard[point.row][point.column] = 3
            }
            _playerTwoPatrolBoatHits = 0
            _playerTwoSunkShips++;
            gameStatusMessage = "Patrol Boat Sunk!"
        }
    }
    
    func addHitPoint(row: Int, column: Int) {
        for var i = 0; i < _playerOneCarrier.count; i++ {
            if (_playerOneCarrier[i].row == row && _playerOneCarrier[i].column == column && !_playerOneCarrier[i].marked) {
                _playerOneCarrierHits++;
                _playerOneCarrier[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerOneBattleship.count; i++ {
            if (_playerOneBattleship[i].row == row && _playerOneBattleship[i].column == column && !_playerOneBattleship[i].marked) {
                _playerOneBattleshipHits++;
                _playerOneBattleship[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerOneSubmarine.count; i++ {
            if (_playerOneSubmarine[i].row == row && _playerOneSubmarine[i].column == column && !_playerOneSubmarine[i].marked) {
                _playerOneSubmarineHits++;
                _playerOneSubmarine[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerOneDestroyer.count; i++ {
            if (_playerOneDestroyer[i].row == row && _playerOneDestroyer[i].column == column && !_playerOneDestroyer[i].marked) {
                _playerOneDestroyerHits++;
                _playerOneDestroyer[i].marked = true
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
        
        for var i = 0; i < _playerTwoCarrier.count; i++ {
            if (_playerTwoCarrier[i].row == row && _playerTwoCarrier[i].column == column && !_playerTwoCarrier[i].marked) {
                _playerTwoCarrierHits++;
                _playerTwoCarrier[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerTwoBattleship.count; i++ {
            if (_playerTwoBattleship[i].row == row && _playerTwoBattleship[i].column == column && !_playerTwoBattleship[i].marked) {
                _playerTwoBattleshipHits++;
                _playerTwoBattleship[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerTwoSubmarine.count; i++ {
            if (_playerTwoSubmarine[i].row == row && _playerTwoSubmarine[i].column == column && !_playerTwoSubmarine[i].marked) {
                _playerTwoSubmarineHits++;
                _playerTwoSubmarine[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerTwoDestroyer.count; i++ {
            if (_playerTwoDestroyer[i].row == row && _playerTwoDestroyer[i].column == column && !_playerTwoDestroyer[i].marked) {
                _playerTwoDestroyerHits++;
                _playerTwoDestroyer[i].marked = true
                return;
            }
        }
        for var i = 0; i < _playerTwoPatrolBoat.count; i++ {
            if (_playerTwoPatrolBoat[i].row == row && _playerTwoPatrolBoat[i].column == column && !_playerTwoPatrolBoat[i].marked) {
                _playerTwoPatrolBoatHits++;
                _playerTwoPatrolBoat[i].marked = true
                return;
            }
        }
        
    }
    
    func placeShips() {
        var playerOneCarrierPlaced = false
        var playerOneBattleshipPlaced = false
        var playerOneSubmarinePlaced = false
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
        
        while (!playerOneCarrierPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(5)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0 && _playerOneGameBoard[rowSelector + 2][colSelector] == 0 && _playerOneGameBoard[rowSelector + 3][colSelector] == 0 && _playerOneGameBoard[rowSelector + 4][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 2][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 3][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 4][colSelector] = 4
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector + 3, column: colSelector, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector + 4, column: colSelector, marked: false))
                    playerOneCarrierPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(5)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector][colSelector + 1] == 0 && _playerOneGameBoard[rowSelector][colSelector + 2] == 0 && _playerOneGameBoard[rowSelector][colSelector + 3] == 0 && _playerOneGameBoard[rowSelector][colSelector + 4] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 2] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 3] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 4] = 4
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector + 3, marked: false))
                    _playerOneCarrier.append(Point(row: rowSelector, column: colSelector + 4, marked: false))
                    playerOneCarrierPlaced = true
                }
            }
        }
        
        while (!playerOneBattleshipPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(6)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0 && _playerOneGameBoard[rowSelector + 2][colSelector] == 0 && _playerOneGameBoard[rowSelector + 3][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 2][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 3][colSelector] = 4
                    _playerOneBattleship.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector + 3, column: colSelector, marked: false))
                    playerOneBattleshipPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(6)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector][colSelector + 1] == 0 && _playerOneGameBoard[rowSelector][colSelector + 2] == 0 && _playerOneGameBoard[rowSelector][colSelector + 3] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 2] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 3] = 4
                    _playerOneBattleship.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    _playerOneBattleship.append(Point(row: rowSelector, column: colSelector + 3, marked: false))
                    playerOneBattleshipPlaced = true
                }
            }
        }
        
        while (!playerOneSubmarinePlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(7)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0 && _playerOneGameBoard[rowSelector + 2][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 2][colSelector] = 4
                    _playerOneSubmarine.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneSubmarine.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerOneSubmarine.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    playerOneSubmarinePlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(7)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector][colSelector + 1] == 0 && _playerOneGameBoard[rowSelector][colSelector + 2] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 2] = 4
                    _playerOneSubmarine.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneSubmarine.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerOneSubmarine.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    playerOneSubmarinePlaced = true
                }
            }
        }
        
        while (!playerOneDestroyerPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(7)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0 && _playerOneGameBoard[rowSelector + 2][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 2][colSelector] = 4
                    _playerOneDestroyer.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneDestroyer.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerOneDestroyer.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    playerOneDestroyerPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(7)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector][colSelector + 1] == 0 && _playerOneGameBoard[rowSelector][colSelector + 2] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 2] = 4
                    _playerOneDestroyer.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOneDestroyer.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerOneDestroyer.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    playerOneDestroyerPlaced = true
                }
            }
        }
        
        while (!playerOnePatrolBoatPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(8)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOnePatrolBoat.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    playerOnePatrolBoatPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(8)))
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector][colSelector + 1] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerOnePatrolBoat.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    playerOnePatrolBoatPlaced = true
                }
            }
        }

        while (!playerTwoCarrierPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(5)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 2][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 3][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 4][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 2][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 3][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 4][colSelector] = 4
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector + 3, column: colSelector, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector + 4, column: colSelector, marked: false))
                    playerTwoCarrierPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(5)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 1] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 2] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 3] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 4] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 2] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 3] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 4] = 4
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector + 3, marked: false))
                    _playerTwoCarrier.append(Point(row: rowSelector, column: colSelector + 4, marked: false))
                    playerTwoCarrierPlaced = true
                }
            }
        }
        
        while (!playerTwoBattleshipPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(6)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 2][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 3][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 2][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 3][colSelector] = 4
                    _playerTwoBattleship.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector + 3, column: colSelector, marked: false))
                    playerTwoBattleshipPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(6)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 1] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 2] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 3] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 2] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 3] = 4
                    _playerTwoBattleship.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    _playerTwoBattleship.append(Point(row: rowSelector, column: colSelector + 3, marked: false))
                    playerTwoBattleshipPlaced = true
                }
            }
        }
        
        while (!playerTwoSubmarinePlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(7)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 2][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 2][colSelector] = 4
                    _playerTwoSubmarine.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoSubmarine.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerTwoSubmarine.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    playerTwoSubmarinePlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(7)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 1] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 2] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 2] = 4
                    _playerTwoSubmarine.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoSubmarine.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerTwoSubmarine.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    playerTwoSubmarinePlaced = true
                }
            }
        }
        
        while (!playerTwoDestroyerPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(7)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 2][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 2][colSelector] = 4
                    _playerTwoDestroyer.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoDestroyer.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    _playerTwoDestroyer.append(Point(row: rowSelector + 2, column: colSelector, marked: false))
                    playerTwoDestroyerPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(7)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 1] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 2] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 2] = 4
                    _playerTwoDestroyer.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoDestroyer.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
                    _playerTwoDestroyer.append(Point(row: rowSelector, column: colSelector + 2, marked: false))
                    playerTwoDestroyerPlaced = true
                }
            }
        }
        
        while (!playerTwoPatrolBoatPlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            if (rowOrColSelector == 0) {
                rowSelector = Int(arc4random_uniform(UInt32(8)))
                colSelector = Int(arc4random_uniform(UInt32(10)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector + 1][colSelector] = 4
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoPatrolBoat.append(Point(row: rowSelector + 1, column: colSelector, marked: false))
                    playerTwoPatrolBoatPlaced = true
                }
            } else {
                rowSelector = Int(arc4random_uniform(UInt32(10)))
                colSelector = Int(arc4random_uniform(UInt32(8)))
                if (_playerTwoGameBoard[rowSelector][colSelector] == 0 && _playerTwoGameBoard[rowSelector][colSelector + 1] == 0) {
                    _playerTwoGameBoard[rowSelector][colSelector] = 4
                    _playerTwoGameBoard[rowSelector][colSelector + 1] = 4
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector, marked: false))
                    _playerTwoPatrolBoat.append(Point(row: rowSelector, column: colSelector + 1, marked: false))
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
