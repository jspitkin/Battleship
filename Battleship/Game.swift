//
//  Game.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import Foundation

class Game {
    // 0 - Water
    // 1 - Not hit ship
    // 2 - Hit ship
    // 3 - Missed missile
    private var _playerOneGameBoard: Array<Array<Int>>
    private var _playerTwoGameBoard: Array<Array<Int>>
    private var _playersTurn: Int
    
    init () {
        _playersTurn = 1
        _playerOneGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
        _playerTwoGameBoard = Array(count:10, repeatedValue: Array(count:10, repeatedValue:0))
    }
    
    func placeShips() {
        
    }
    
    func fireMissle(player: Int, column: Int, row: Int) {
        
    }
}