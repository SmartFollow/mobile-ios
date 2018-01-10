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
    
    //let participation = Int((self.student.getCriteria(id: 1)?.value)!)
    //let noWork = Int((self.student.getCriteria(id: 2)?.value)!)
    //let bavardage = Int((self.student.getCriteria(id: 3)?.value)!)
    
    addCriteria(alert: alert, i: 1, title: "Participation", criterionId: 1)
    addCriteria(alert: alert, i: 1, title: "Devoir non réalisés", criterionId: 2)
    addCriteria(alert: alert, i: 1, title: "Bavardage", criterionId: 3)
    alert.show()
  }
  
  public func addCriteria(alert: UIAlertController, i: Int, title: String, criterionId: Int) {
    let json: [String: Any] = ["criterion_id": 1, "value": 42]
    
    alert.addAction(UIAlertAction(title: title , style: .default, handler: { (action:UIAlertAction) in
      ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.student.evaluation!.id)/criteria", method: "POST", json: json, completion: { (result: Data?) in
        self.finishAnimation()
        self.student.incCriteria(id: criterionId)
      })
    }))
  }
  
}
