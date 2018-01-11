//
//  StudentsInDifficultiesController.swift
//  client-ipad
//
//  Created by Alexandre Page on 26/12/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class StudentsInDifficultiesController: UIViewController {
  var students = [Student]()
  var position: Position = .Left
  var height: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let semaphore = DispatchSemaphore(value: 0)
    ApiManager.sharedInstance.fetch(endPoint: "/api/difficulties") { (result: Data?) in
      self.students = ApiManager.parseDifficulty(result: result)
      semaphore.signal()
    }
    semaphore.wait()
    setup()
  }
  
  func setup() {
    var view: ViewWrapper
    var row: CGFloat = 100
    let width =  self.view.bounds.size.width
    let height = self.view.bounds.size.height
    
    for student in self.students {
      switch self.position {
      case .Left:
        view = ViewWrapper(frame:  CGRect(x: 50, y: Int(row), width: 200, height: 250), student: student)
      case .Middle:
        view = ViewWrapper(frame: CGRect(x: Int((width / 2) - 100), y: Int(row), width: 200, height: 250), student: student)
      case .Right:
        view = ViewWrapper(frame: CGRect(x: Int(width - 200 - 50), y: Int(row), width: 200, height: 250), student: student)
        row += 300
      }
      self.view.addSubview(view)
      self.position++
    }
    self.height.constant = row == 100 ? 330 : row + 30
  }
  
  
}
