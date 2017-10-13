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
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let lessons = ApiManager.parseLessons(result: result)
            var tmpArr = [String]()
            for lesson in lessons {
                tmpArr.append(formatter.string(from: lesson.timeStart))
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
}

extension CourseFlowController : UIPickerViewDelegate,  UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
