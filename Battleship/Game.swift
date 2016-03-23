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
    
    func placeShips() {
        var twoShipPlayerOnePlaced = false
        var threeShipPlayerOnePlaced = false
        var threeTwoShipPlaceOnePlaced = false
        var fourShipPlayerOnePlaced = false
        var fiveShipPlayerOnePlaced = false
        
        var twoShipPlayerTwoPlaced = false
        var threeShipPlayerTwoPlaced = false
        var threeTwoShipPlayerTwoPlaced = false
        var fourShipPlayerTwoPlaced = false
        var fiveShipPlayerTwoPlaced = false
        
        var rowSelector: Int = 0
        var colSelector: Int = 0
        var rowOrColSelector: Int = 0
        
        while (!twoShipPlayerOnePlaced) {
            rowOrColSelector = Int(arc4random_uniform(UInt32(2)))
            rowSelector = Int(arc4random_uniform(UInt32(9)))
            colSelector = Int(arc4random_uniform(UInt32(9)))
            if (rowOrColSelector == 0) {
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector][colSelector + 1] = 4
                    twoShipPlayerOnePlaced = true
                }
            } else {
                if (_playerOneGameBoard[rowSelector][colSelector] == 0 && _playerOneGameBoard[rowSelector + 1][colSelector] == 0) {
                    _playerOneGameBoard[rowSelector][colSelector] = 4
                    _playerOneGameBoard[rowSelector + 1][colSelector] = 4
                    twoShipPlayerOnePlaced = true
                }
            }
        }
    }
    
    // 0 - Water
    // 1 - Miss
    // 2 - Hit ship
    // 3 - Sunk ship
    // 4 - Ship
    func fireMissle(row: Int, column: Int) {
        
        if (playersTurn == 1) {
            let hitCellValueTwo: Int = _playerTwoGameBoard[row][column]
            if (hitCellValueTwo == 1 || hitCellValueTwo == 2 || hitCellValueTwo == 3) {
                gameStatusMessage = "Invalid Missle"
            }
            else if (hitCellValueTwo == 0) {
                _playerTwoGameBoard[row][column] = 1
                gameStatusMessage = "MISS!"
            }
            else if (hitCellValueTwo == 4) {
                _playerTwoGameBoard[row][column] = 2
                gameStatusMessage = "HIT!"
            }
        }
        else {
            let hitCellValueOne: Int = _playerOneGameBoard[row][column]
            if (hitCellValueOne == 1 || hitCellValueOne == 2 || hitCellValueOne == 3) {
                gameStatusMessage = "Invalid Missle"
            }
            else if (hitCellValueOne == 0) {
                _playerOneGameBoard[row][column] = 1
                gameStatusMessage = "MISS!"
            }
            else if (hitCellValueOne == 4) {
                _playerOneGameBoard[row][column] = 2
                gameStatusMessage = "HIT!"
            }
            
        }
        changeTurns()
        delegate?.successfulMissle()
    }
    
    func changeTurns() {
        if (_playersTurn == 1) {
            //gameStatusMessage = "Player Two's Turn"
            _playersTurn = 2
        }
        else {
            //gameStatusMessage = "Player One's Turn"
            _playersTurn = 1
        }
        print("\(gameStatusMessage)")
    }
}