//
//  GameViewController.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private var _gameList: GameList!
    private var _gameIndex: Int?
    private var _game: Game?
    
    var gameList: GameList {
        get { return _gameList }
        set { _gameList = newValue }
    }
    
    var gameIndex: Int {
        get { return _gameIndex! }
        set { _gameIndex = newValue }
    }
    
    var game: Game {
        get { return _game! }
        set { _game = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}