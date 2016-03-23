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
    
    func saveGames() {
        do {
            let documentsPath = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let filePath = documentsPath.URLByAppendingPathComponent("savedGames.txt")
            
            for game in _games {
                let _playerOneGameBoard = try NSJSONSerialization.dataWithJSONObject(game.playerOneGameBoard, options: NSJSONWritingOptions(rawValue: 0))
                let _playerTwoGameBoard = try NSJSONSerialization.dataWithJSONObject(game.playerTwoGameBoard, options: NSJSONWritingOptions(rawValue: 0))
                let _playersTurn = try NSJSONSerialization.dataWithJSONObject(game.playersTurn, options: NSJSONWritingOptions(rawValue: 0))
                let _gameStatusMessage = try NSJSONSerialization.dataWithJSONObject(game.gameStatusMessage, options: NSJSONWritingOptions(rawValue: 0))
                let gameover = try NSJSONSerialization.dataWithJSONObject(game.gameOver, options: NSJSONWritingOptions(rawValue: 0))
                
                if let file = NSFileHandle(forWritingAtPath:filePath.absoluteString) {
                    file.writeData(_playerOneGameBoard)
                    file.writeData(_playerTwoGameBoard)
                    file.writeData(_playersTurn)
                    file.writeData(_gameStatusMessage)
                    file.writeData(gameover)
                }
                
            }
            
        } catch _ {
            
        }
    }
    
}