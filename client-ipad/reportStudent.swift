//
//  reportStudent.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class reportStudent: UIAlertController {
    
    var a: Int = 0
    var b: Int = 0
    var c: Int = 0
    var evaluation: Evaluation?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addAction(UIAlertAction(title: "Participation", style: .default, handler: { (action:UIAlertAction) in
            ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.evaluation?.id)/criteria", method: "POST", parameters: "criterion_id=1&value=\(self.a)", completion: { (result: Data?) in
                self.a = self.a + 1
            })
        }))
        
        self.addAction(UIAlertAction(title: "Devoir non réalisés", style: .default, handler: { (action: UIAlertAction) in
            ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.evaluation?.id)/criteria", method: "POST", parameters: "criterion_id=2&value=\(self.b)", completion: { (result: Data?) in
                self.b = self.b + 1
            })
        }))
        
        self.addAction(UIAlertAction(title: "Bavardage en classe", style: .default, handler: { (action: UIAlertAction) in
            ApiManager.sharedInstance.fetch(endPoint: "/api/evaluations/\(self.evaluation?.id)/criteria", method: "POST", parameters: "criterion_id=3&value=\(self.c)", completion: { (result: Data?) in
                self.c = self.c + 1
            })
        }))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
