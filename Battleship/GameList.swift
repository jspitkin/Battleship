//
//  GameList.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import Foundation

class GameList {
    private var _games: [Game] = []
    
    var gameCount: Int! {
        return _games.count
    }
    
    func gameWithIndex(gameIndex: Int) -> Game {
        return _games[gameIndex]
    }
    
    func addGame(game: Game) {
        _games.append(game)
    }
    
    func removeGameWithIndex(gameIndex: Int) {
        _games.removeAtIndex(gameIndex)
    }
    
    
}