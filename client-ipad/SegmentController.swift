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
    let focus = UIImage(named: "focus")
    let red = UIImage(named: "red")
    let font = UIFont.boldSystemFont(ofSize: 18)
    
    self.setBackgroundImage(red, for: UIControlState.disabled, barMetrics: UIBarMetrics.default)
    self.setBackgroundImage(black , for: UIControlState.normal, barMetrics: UIBarMetrics.default)
    self.setBackgroundImage(focus, for: UIControlState.selected, barMetrics: UIBarMetrics.default)
    
    self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: font], for: UIControlState.normal)
    self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: font], for: UIControlState.selected)
    self.layer.cornerRadius = 45
    self.layer.masksToBounds = true
  }
  
}
