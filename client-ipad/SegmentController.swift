//
//  SegmentController.swift
//  client-ipad
//
//  Created by Alexandre Page on 18/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class SegmentController: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let black = UIImage(named: "black")
        let red = UIImage(named: "red")
        self.setBackgroundImage(black , for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        self.setBackgroundImage(red, for: UIControlState.selected, barMetrics: UIBarMetrics.default)
        self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.selected)
        self.layer.cornerRadius = 45
        self.layer.masksToBounds = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
