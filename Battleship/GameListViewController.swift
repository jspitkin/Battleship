//
//  GameListViewController.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var _gameList: GameList = GameList()

    private var _gameListView: UITableView?
    
    override func loadView() {
        _gameListView = UITableView()
        view = _gameListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _gameListView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.title = "Battleship"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "newGame")
        //_gameListView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        _gameListView!.dataSource = self
        _gameListView!.delegate = self
        _gameListView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _gameList.gameCount;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = _gameListView!.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = "\(indexPath.item)"
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let game: Game = _gameList.gameWithIndex(indexPath.item)
        let gameIndex: Int = indexPath.item
        
        let gameViewController: GameViewController = GameViewController()
        gameViewController.gameList = _gameList
        gameViewController.gameIndex = gameIndex
        gameViewController.game = game
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func newGame() {
        let gameViewController: GameViewController = GameViewController()
        let newGame = Game()
        _gameList.addGame(newGame)
        gameViewController.gameList = _gameList
        gameViewController.gameIndex = _gameList.gameCount - 1
        _gameListView!.reloadData()
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
