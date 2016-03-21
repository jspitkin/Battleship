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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _gameInformation!.text = game.gameStatusMessage
        _gameView.game = _game!
        self.view.addSubview(_gameInformation!)
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
        sleep(2)
        self.navigationController?.pushViewController(_changeUserViewController, animated: true)
        gameView?.setNeedsDisplay()
    }
    
    func changeTurn() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}