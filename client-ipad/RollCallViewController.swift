//
//  CallingStudentViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RollCallViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        ApiManager.sharedInstance.b(endPoint: "/api/student-classes/1/students") { (result: Data?) in
            let StudentClass: StudentClass = self.parseClassStudent(result: result)
            
            var leftY = 200
            var rightY = 200
            var i = true
            self.scrollView.contentSize.height = 325.0 + (((CGFloat) (StudentClass.students.count / 2) * (300.0)) - 50.0)
            let goodX = self.view.bounds.size.width - 100 - 200
            for student in StudentClass.students {
                
                let goodY = i ? leftY : rightY
                let goodX = i ? 100 : self.view.bounds.size.width - 100 - 200
                DispatchQueue.main.async {
                    let view = RollCallUIView(frame: CGRect(x: Int(goodX), y: goodY, width: 200, height: 250), student: student)
                    self.scrollView.addSubview(view)
                }
                if (i) {
                    leftY += 300
                } else {
                    rightY += 300
                }
                i = !i
            }
        }
        
    }
    
    func parseClassStudent(result: Data?) -> StudentClass {
        let studentClass = StudentClass()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                for jsonStudent in json {
                    if let id = jsonStudent["id"], let email = jsonStudent["email"], let firstName = jsonStudent["firstname"], let lastName = jsonStudent["lastname"], let classId = jsonStudent["class_id"], let groupId = jsonStudent["group_id"] {
                        print(id)
                        let student = Student(id: id as! Int, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, classId: classId as! Int, groupId: groupId as! Int)
                        studentClass.students.append(student)
                    }
                }
            }
        }
        catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return studentClass
    }
}
