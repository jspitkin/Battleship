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
    // 1 - Not hit ship
    // 2 - Hit ship
    // 3 - Missed missile
    // 4 - Sunk ship
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
    }
    
    func placeShips() {
        
    }
    
    func fireMissle(row: Int, column: Int) {
        
        changeTurns()
        delegate?.successfulMissle()
    }
    
    func changeTurns() {
        if (_playersTurn == 1) {
            gameStatusMessage = "Player Two's Turn"
            _playersTurn = 2
        }
        else {
            gameStatusMessage = "Player One's Turn"
            _playersTurn = 1
        }
        print("\(gameStatusMessage)")
    }
}