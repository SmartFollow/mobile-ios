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
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self

        
        ApiManager.sharedInstance.b(endPoint: "/api/lessons") { (result: Data?) in
            
            var lessons = self.parseLesson(result: result)
            var tmpArr = [String]()
            for lesson in lessons {
                tmpArr.append(lesson.start)
            }
            self.pickerData = tmpArr
            DispatchQueue.main.async {
                self.picker.reloadAllComponents()
            }
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async(execute: { () -> Void in
            self.professorLabel.text = "\(UserDefaults.standard.value(forKey: "firstName")!) \(UserDefaults.standard.value(forKey: "lastName")!)"
        })
    }
    
    func parseLesson(result : Data?) -> [Lesson] {
        var lessons = [Lesson]()
        do {
            if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [[String: Any]] {
                
                for jsonLesson in json {
                    if let id = jsonLesson["id"], let subjectId = jsonLesson["subject_id"], let reservationId = jsonLesson["reservation_id"], let studentClassId = jsonLesson["student_class_id"], let start = jsonLesson["start"], let end = jsonLesson["end"] {
                        print("\(id) \(subjectId) \(reservationId) \(studentClassId) \(start) \(end)")
                            let lesson = Lesson(id: id as! Int, subjectId: subjectId as! Int, reservationId: 5 as! Int, studentClassId: studentClassId as! Int, start: start as! String, end: end as! String)
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
        return lessons
    }
    
}

extension CourseFlowController : UIPickerViewDelegate,  UIPickerViewDataSource {
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
