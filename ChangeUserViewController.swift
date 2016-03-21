//
//  ChangeUserViewController.swift
//  Battleship
//
//  Created by Jake Pitkin on 3/18/16.
//  Copyright © 2016 Jake Pitkin. All rights reserved.
//

import UIKit

class ChangeUserViewController: UIViewController {

    private var _changeUserView: ChangeUserView = ChangeUserView()
    
    var changeView: ChangeUserView {
        get { return _changeUserView }
    }
    
    override func loadView() {
        view = _changeUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let label = UILabel(frame: CGRectMake(0, 0, 300, 600))
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(24)
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.text = "Give the device \n to your enemy. \n (click to continue)"
        self.view.addSubview(label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}