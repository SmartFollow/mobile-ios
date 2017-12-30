//
//  ButtonWrapper.swift
//  client-ipad
//
//  Created by Alexandre Page on 28/12/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class ViewWrapper: UIView {
  
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet var contentView: ViewWrapper!
  var studentButton: UIButtonStudent!
  
  required init(frame: CGRect, student: Student) {
    super.init(frame: frame)
    self.studentButton = UIButtonStudent(student: student)
    loadXib()
    mainLabel.text = "\(student.firstName) \(student.lastName)"
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func loadXib() {
    Bundle.main.loadNibNamed("ViewWrapper", owner: self, options: nil)
    contentView.addSubview(studentButton)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
