//
//  StudentButton.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RollCallButton: UIButton {
    
    var stateStudent: Int!
    var studentId: Int!
    var iconTab = ["present.png", "late.png", "absent.png"]
    var activityIndicator: UIActivityIndicatorView
    var evaluationId: Int!
    
    required init(frame: CGRect, student: Student) {
        self.studentId = student.id
        self.stateStudent = 0
        self.activityIndicator = UIActivityIndicatorView()
        self.evaluationId = 5
        
        super.init(frame: frame)
        initActivityMonitor()
        self.addTarget(self, action:#selector(self.changeState(sender:)), for: .touchUpInside)
        DispatchQueue.main.async {
            self.setBackgroundImage(UIImage(named: "bechad.png"), for: .normal)
            self.setImage(UIImage(named: self.iconTab[self.stateStudent]), for: .normal)
            self.imageEdgeInsets = UIEdgeInsetsMake(-150, -150, 0, 0)
        }
    }
    
    func initActivityMonitor() {
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        self.activityIndicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
        self.activityIndicator.alpha = 0.5
        self.addSubview(self.activityIndicator)
    }
    
    func changeState(sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        self.isEnabled = false
        print("Evaluation Id : \(self.evaluationId)")
        ApiManager.sharedInstance.b(endPoint: "/api/evaluations/\(self.evaluationId!)/absences", method: "POST") { (result: Data?) in
            
            do {
                if let json = try JSONSerialization.jsonObject(with: result!, options: []) as?
                    [String: Any] {
                    if json["success"] != nil {
                        self.stateStudent = self.stateStudent + 1
                        if (self.stateStudent > 2) {
                            self.stateStudent = 0
                        }
                        DispatchQueue.main.async(){
                            self.activityIndicator.stopAnimating()
                            self.isEnabled = true
                            self.setImage(UIImage(named: self.iconTab[self.stateStudent]), for: .normal)
                        }
                    }
                }
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
