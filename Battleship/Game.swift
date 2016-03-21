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
    
    var playersTurn: Int {
        get { return _playersTurn }
        set { _playersTurn = newValue }
    }
    
     weak var delegate: GameDelegate? = nil
    
    init () {
        _playersTurn = 1
        _playerOneGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
        _playerTwoGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
    }
    
    func placeShips() {
        
    }
    
    func fireMissle(row: Int, column: Int) {
        changeTurns()
        print("\(_playersTurn)")
        delegate?.successfulMissle()
    }
    
    func changeTurns() {
        if (_playersTurn == 1) {
            _playersTurn = 2
        }
        else {
            _playersTurn = 1
        }
    }
}