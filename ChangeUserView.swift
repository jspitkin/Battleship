//
//  ChangeUserView.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/20/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

protocol ChangeDelegate: class
{
    func changeTurn()
}

class ChangeUserView: UIView {
    
    weak var delegate: ChangeDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGrayColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        delegate?.changeTurn()
    }
}
