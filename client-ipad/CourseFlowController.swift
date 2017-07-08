//
//  CourseFlowController.swift
//  client-ipad
//
//  Created by Alexandre Page on 08/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class CourseFlowController: UIViewController {
    
    @IBOutlet weak var professorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiManager.sharedInstance.b(endPoint: "/lessons") { (result: Data?) in
                self.fetchLesson(result: result)
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async(execute: { () -> Void in
            self.professorLabel.text = "\(UserDefaults.standard.value(forKey: "firstName")!) \(UserDefaults.standard.value(forKey: "lastName")!)"
        })
    }
    
    func fetchLesson(result : Data?) {
        var lessons = [Lesson]()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                
                for jsonLesson in json {
                    if let id = jsonLesson["id"], let subjectId = jsonLesson["subject_id"], let reservationId = jsonLesson["reservation_id"], let studentClassId = jsonLesson["student_class_id"], let start = jsonLesson["start"], let end = jsonLesson["end"] {
                        
                        let lesson = Lesson(id: id as! Int, subjectId: subjectId as! Int, reservationId: reservationId as! Int, studentClassId: studentClassId as! Int, start: start as! String, end: end as! String)
                        lessons.append(lesson)
                    }
                }
                
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: lessons)
                UserDefaults.standard.set(encodedData, forKey: "lessons")
                UserDefaults.standard.synchronize()
  
//  https://stackoverflow.com/questions/29986957/save-custom-objects-into-nsuserdefaults
//                let decoded  = UserDefaults.standard.object(forKey: "lessons") as! Data
//                let decodedLessons = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Lesson]
//                for lesson in decodedLessons {
//                    print(lesson.id)
//                }
            }
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    
}
