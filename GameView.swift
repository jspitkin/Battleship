//
//  GameView.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/20/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

protocol GridDelegate: class
{
    func fireOnCell(row: Int, column: Int)
}

class GameView: UIView {
    
    private var _clickedCellX: Int?
    private var _clickedCellBottomY: Int?
    private var _clickedCellTopY: Int?
    
    private var _game: Game?
    
    var game: Game {
        get { return _game! }
        set { _game = newValue }
    }
    
    weak var delegate: GridDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        let cellSizeX = bounds.height * CGFloat(0.046)
        let cellSizeY = bounds.height * CGFloat(0.035)
        _clickedCellX = Int(touchPoint.x / cellSizeX) - 1
        _clickedCellBottomY = Int((touchPoint.y - bounds.height * 0.565) / cellSizeY) - 1
        _clickedCellTopY = Int((touchPoint.y - bounds.height * 0.2 + 20) / cellSizeY) - 1
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        let cellSizeX = bounds.height * CGFloat(0.046)
        let cellSizeY = bounds.height * CGFloat(0.035)
        let releasedCellX = Int(touchPoint.x / cellSizeX) - 1
        let releasedCellBottomY = Int((touchPoint.y - bounds.height * 0.565) / cellSizeY) - 1
        let releasedCellTopY = Int((touchPoint.y - bounds.height * 0.2 + 20) / cellSizeY) - 1
        
        // Firing on bottom board
        if (releasedCellX == _clickedCellX && releasedCellBottomY == _clickedCellBottomY && _game!.playersTurn == 1 && !game.gameOver) {
            if (_clickedCellX >= 0 && _clickedCellX <= 9 && _clickedCellBottomY >= 0 && _clickedCellBottomY <= 9) {
                delegate?.fireOnCell(_clickedCellX!, column: _clickedCellBottomY!)
            }
        }
        
        // Firing on top board
        if (releasedCellX == _clickedCellX && releasedCellTopY == _clickedCellTopY && _game!.playersTurn == 2 && !game.gameOver) {
            if (_clickedCellX >= 0 && _clickedCellX <= 9 && _clickedCellTopY >= 0 && _clickedCellTopY <= 9) {
                delegate?.fireOnCell(_clickedCellX!, column: _clickedCellTopY!)
            }
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        // Draws the bottom grid
        var originTopX = 27.0
        var originTopY = 342.0
        let cellWidth = bounds.height * 0.043
        let cellHeight = bounds.height * 0.032
        for column in 0...(_game!.playerTwoGameBoard.count - 1) {
            for row in 0...(_game!.playerTwoGameBoard.count - 1) {
                let context = UIGraphicsGetCurrentContext()
                CGContextSetLineWidth(context, 1.0)
                var squareColor: UIColor = getSquareColor(_game!.playerTwoGameBoard[row][column])
                if (game.playersTurn == 1 && _game!.playerTwoGameBoard[row][column] == 4) {
                    squareColor = UIColor.cyanColor()
                }
                CGContextSetStrokeColorWithColor(context, squareColor.CGColor)
                let rectangle = CGRectMake(CGFloat(originTopX), CGFloat(originTopY), cellWidth, cellHeight)
                originTopX += Double(cellWidth) + 1.7
                CGContextAddRect(context, rectangle)
                CGContextStrokePath(context)
                CGContextSetFillColorWithColor(context, squareColor.CGColor)
                CGContextFillRect(context, rectangle)
            }
            originTopY += Double(cellHeight) + 1.7
            originTopX = 27.0
        }
        
        // Draws the top grid
        var originBottomX = 27.0
        var originBottomY = 115.0
        for column in 0...(_game!.playerOneGameBoard.count - 1) {
            for row in 0...(_game!.playerOneGameBoard.count - 1) {
                let context = UIGraphicsGetCurrentContext()
                CGContextSetLineWidth(context, 1.0)
                var squareColor: UIColor = getSquareColor(_game!.playerOneGameBoard[row][column])
                if (game.playersTurn == 2 && _game!.playerOneGameBoard[row][column] == 4) {
                    squareColor = UIColor.cyanColor()
                }
                CGContextSetStrokeColorWithColor(context, squareColor.CGColor)
                let rectangle = CGRectMake(CGFloat(originBottomX), CGFloat(originBottomY), cellWidth, cellHeight)
                originBottomX += Double(cellWidth) + 1.7
                CGContextAddRect(context, rectangle)
                CGContextStrokePath(context)
                CGContextSetFillColorWithColor(context, squareColor.CGColor)
                CGContextFillRect(context, rectangle)
            }
            originBottomY += Double(cellHeight) + 1.7
            originBottomX = 27.0
        }
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        let strokePath: CGMutablePathRef = CGPathCreateMutable()
        CGContextSetLineWidth(context, 2)
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        
        var gridY = Double(bounds.height) * 0.2
        var gridX = Double(bounds.width) * 0.08181
        
        for _ in 1...11 {
            CGPathMoveToPoint(strokePath, nil, CGFloat(gridX), bounds.height * 0.2)
            CGPathAddLineToPoint(strokePath, nil, CGFloat(gridX) , bounds.height * 0.55)
            
            CGPathMoveToPoint(strokePath, nil, CGFloat(gridX), bounds.height * 0.6)
            CGPathAddLineToPoint(strokePath, nil, CGFloat(gridX) , bounds.height * 0.95)
            gridX += Double(bounds.height) * 0.046
            
            CGPathMoveToPoint(strokePath, nil, bounds.width * 0.08181, CGFloat(gridY) + bounds.height * 0.4)
            CGPathAddLineToPoint(strokePath, nil, bounds.width * 0.9, CGFloat(gridY) + bounds.height * 0.4)
            
            CGPathMoveToPoint(strokePath, nil, bounds.width * 0.08181, CGFloat(gridY))
            CGPathAddLineToPoint(strokePath, nil,  bounds.width * 0.9, CGFloat(gridY))
            gridY += Double(bounds.height) * 0.035
        }
        
        CGContextAddPath(context, strokePath)
        CGContextStrokePath(context)
        
    }
    
    // 0 - Water
    // 1 - Miss
    // 2 - Hit ship
    // 3 - Sunk ship
    // 4 - Ship
    func getSquareColor(squareCode: Int) -> UIColor {
        switch squareCode {
        case 0:
            return UIColor.cyanColor()
        case 1:
            return UIColor.lightGrayColor()
        case 2:
            return UIColor.yellowColor()
        case 3:
            return UIColor.redColor()
        case 4:
            return UIColor.brownColor()
        default:
            return UIColor.cyanColor()
        }
    }
    
}

