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
    private var _clickedCellY: Int?
    
    weak var delegate: GridDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.cyanColor()
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
        _clickedCellY = Int((touchPoint.y - bounds.height * 0.565) / cellSizeY) - 1
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        let cellSizeX = bounds.height * CGFloat(0.046)
        let cellSizeY = bounds.height * CGFloat(0.035)
        let releasedCellX = Int(touchPoint.x / cellSizeX) - 1
        let releasedCellY = Int((touchPoint.y - bounds.height * 0.565) / cellSizeY) - 1
        
        if (releasedCellX == _clickedCellX && releasedCellY == _clickedCellY) {
            if (_clickedCellX >= 0 && _clickedCellX <= 9 && _clickedCellY >= 0 && _clickedCellY <= 9) {
                delegate?.fireOnCell(_clickedCellX!, column: _clickedCellY!)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        let strokePath: CGMutablePathRef = CGPathCreateMutable()
        CGContextSetLineWidth(context, 1)
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
    
}

