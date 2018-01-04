//
//  UIButtonStudent.swift
//  client-ipad
//
//  Created by Alexandre Page on 26/12/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class UIButtonStudent: UIButton {
  
  let myFrame = CGRect(x: 0, y: 0, width: 200, height: 200)

  required init?(student: Student) {
    super.init(frame: myFrame)
    self.setBackgroundImage(student.avatar, for: .normal)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    self.isEnabled = false
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.frame.width / 2
  }
  
}
