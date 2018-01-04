//
//  GossipButtonExtension.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension StudentButton {
  
  public func gossip() {
    let alert = UIAlertController(title: "Remarque sur l'élève", message: "", preferredStyle: .alert)
    addCriteria(alert: alert, i: 0, title: "Participation", criterionId: 1)
    addCriteria(alert: alert, i: 0, title: "Devoir non réalisés", criterionId: 2)
    addCriteria(alert: alert, i: 0, title: "Bavardage", criterionId: 3)
    alert.show()
  }
  
  public func addCriteria(alert: UIAlertController, i: Int, title: String, criterionId: Int) {
    alert.addAction(UIAlertAction(title: title , style: .default, handler: { (action:UIAlertAction) in
      ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.student.evaluation!.id)/criteria", method: "POST", parameters: "criterion_id=\(criterionId)&value=\(i)", completion: { (result: Data?) in
        self.finishAnimation()
      })
    }))
  }
  
}
