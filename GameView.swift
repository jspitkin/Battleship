//
//  GameView.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/20/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

//protocol PaintingDelegate: class
//{
//    func addStroke(newStroke: Stroke)
//}

class GameView: UIView {
    
    private var _startX: CGFloat = 0
    private var _startY: CGFloat = 0
    
    
    var color: CGColor = UIColor.blackColor().CGColor
    var endCap: CGLineCap = CGLineCap.Round
    var lineJoin: CGLineJoin = CGLineJoin.Round
    var width: Float = 10
    
    //weak var delegate: PaintingDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.cyanColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)

    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        let strokePath: CGMutablePathRef = CGPathCreateMutable()
        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
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

