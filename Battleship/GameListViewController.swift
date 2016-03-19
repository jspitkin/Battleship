//
//  GameListViewController.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var _gameList: GameList = GameList()
    
    private var _gameListView: UICollectionView {
        return view as! UICollectionView
    }
    
    override func loadView() {
        let gamesLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        view = UICollectionView(frame: CGRectZero, collectionViewLayout: gamesLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Battleship"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "newGame")
        _gameListView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        _gameListView.dataSource = self
        _gameListView.delegate = self
    }
    
    func newGame() {
        let gameViewController: GameViewController = GameViewController()
        let newGame = Game()
        _gameList.addGame(newGame)
        gameViewController.gameList = _gameList
        gameViewController.gameIndex = _gameList.gameCount - 1
        _gameListView.reloadData()
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let game: Game = _gameList.gameWithIndex(indexPath.item)
        let gameIndex: Int = indexPath.item
        
        let gameViewController: GameViewController = GameViewController()
        gameViewController.gameList = _gameList
        gameViewController.gameIndex = gameIndex
        gameViewController.game = game
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _gameList.gameCount;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionViewCell.self), forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        
        let title = UILabel(frame: CGRectMake(cell.bounds.width * 0.38, 5, cell.bounds.size.width, 40))
        title.text = "\(indexPath.item + 1)"
        
        cell.addSubview(title)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
