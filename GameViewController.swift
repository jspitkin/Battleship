//
//  GameViewController.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GridDelegate, GameDelegate, ChangeDelegate {
    
    private var _gameList: GameList!
    private var _gameIndex: Int?
    private var _game: Game?
    private var _gameView: GameView = GameView()
    private var _changeUserViewController: ChangeUserViewController = ChangeUserViewController()
    private var _gameInformation: UILabel?
    
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
    
    var gameView: GameView? {
        get { return _gameView }
        set { _gameView = newValue! }
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        _gameInformation = UILabel(frame: CGRectMake(57, 80, 200, 30))
        _gameInformation!.textColor = UIColor.blackColor()
        _gameInformation!.font = UIFont.systemFontOfSize(24)
        _gameInformation!.textAlignment = NSTextAlignment.Center
    }
    
    override func loadView() {
        view = _gameView
        _gameView.delegate = self
        _game!.delegate = self
        _changeUserViewController.changeView.delegate = self
        _gameView.game = game
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _gameInformation!.text = game.gameStatusMessage
        _gameView.game = _game!
        self.view.addSubview(_gameInformation!)
        
        let playerOneLabel: UILabel = UILabel(frame: CGRectMake(57, 305, 200, 30))
        playerOneLabel.textColor = UIColor.blackColor()
        playerOneLabel.font = UIFont.systemFontOfSize(12)
        playerOneLabel.textAlignment = NSTextAlignment.Center
        playerOneLabel.text = "Player One"
        self.view.addSubview(playerOneLabel)
        
        let playerTwoLabel: UILabel = UILabel(frame: CGRectMake(57, 533, 200, 30))
        playerTwoLabel.textColor = UIColor.blackColor()
        playerTwoLabel.font = UIFont.systemFontOfSize(12)
        playerTwoLabel.textAlignment = NSTextAlignment.Center
        playerTwoLabel.text = "Player Two"
        self.view.addSubview(playerTwoLabel)
        
        self.navigationItem.hidesBackButton = true
        let gameListButton = UIBarButtonItem(title: "Game List", style: UIBarButtonItemStyle.Plain, target: self, action: "backToGameList")
        self.navigationItem.leftBarButtonItem = gameListButton;
    }
    
    func backToGameList() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fireOnCell(row: Int, column: Int) {
        game.fireMissle(row, column: column)
    }
    
    func successfulMissle() {
        _gameInformation!.text = game.gameStatusMessage

        // Pause for two seconds to user can see result before passing device
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 2))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            self.passToEnemyScreen()
        }
    }
    
    func passToEnemyScreen() {
        self.navigationController?.pushViewController(_changeUserViewController, animated: false)
        gameView?.setNeedsDisplay()
    }
    
    func changeTurn() {
        if (_game?.playersTurn == 2) {
            _game?.gameStatusMessage = "Player Two's Turn"
        }
        else {
            _game?.gameStatusMessage = "Player One's Turn"
        }
        _gameInformation?.text = game.gameStatusMessage
        self.navigationController?.popViewControllerAnimated(true)
    }
}