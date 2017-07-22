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
        
        self.scrollView.contentSize.height = 2048
        
        ApiManager.sharedInstance.b(endPoint: "/student-classes/6/students") { (result: Data?) in
            let StudentClass: StudentClass = self.parseClassStudent(result: result)
            
            var leftY = 100
            var rightY = 100
            var i = true
            for student in StudentClass.students {
                if (i) {
                    let button = RollCallButton(frame: CGRect(x: 100, y: leftY, width: 200, height: 200), student: student)
                    leftY += 300
                    DispatchQueue.main.async {
                        self.scrollView.addSubview(button)
                    }
                } else {
                    let button = RollCallButton(frame: CGRect(x: 400, y: rightY, width: 200, height: 200), student: student)
                    rightY += 300
                    DispatchQueue.main.async {
                        self.scrollView.addSubview(button)
                    }
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
