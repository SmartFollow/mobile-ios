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
    
    addCriteria(alert: alert, title: "Participation", criterionId: 1)
    addCriteria(alert: alert, title: "Devoir non réalisés", criterionId: 2)
    addCriteria(alert: alert, title: "Bavardage", criterionId: 3)
    alert.show()
  }
  
  public func addCriteria(alert: UIAlertController, title: String, criterionId: Int) {
    alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action:UIAlertAction) in
      let count = self.student.getCriteria(id: criterionId)!
      
      if count == 0 {
        let json: [String: Any] = ["criterion_id": criterionId, "value": 1]
        ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.student.evaluation!.id)/criteria", method: "POST", json: json, completion: { (result: Data?) in
          self.finishAnimation()
          self.student.criteria = ApiManager.parseCriteria(result: result)!
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotificationForItemEdit"), object: nil)
        })
      }
      else {
        let json: [String: Any] = ["value": count + 1]
        ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.student.evaluation!.id)/criteria/\(criterionId)", method: "PUT", json: json, completion: { (result: Data?) in
          self.finishAnimation()
          self.student.incCriteria(id: criterionId)
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotificationForItemEdit"), object: nil)
        })
      }
    }))
  }
  
}
