//
//  CoursesViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 02/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    @IBOutlet weak var profilPicture: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var lesson: Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilPicture.asCircle()
        
        ApiManager.sharedInstance.fetch(endPoint: "/api/student-classes/\(self.lesson.studentClassId)/students") { (result: Data?) in
            let StudentClass: [Student] = ApiManager.parseClassStudent(result: result)
            
            var leftY = 600
            var rightY = 600
            var i = true
            DispatchQueue.main.async {
                self.scrollView.contentSize.height = 325.0 + (((CGFloat) (StudentClass.count / 2) * (300.0)) - 50.0)
            }
            let goodX = self.view.bounds.size.width - 100 - 200
            for student in StudentClass {
                let goodY = i ? leftY : rightY
                let goodX = i ? 100 : self.view.bounds.size.width - 100 - 200
                DispatchQueue.main.async {
                    let view = RollCallUIView(frame: CGRect(x: Int(goodX), y: goodY, width: 200, height: 250), student: student, lesson: self.lesson)
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
    
    @IBAction func onChange(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            setButton(state: 0)
        case 1:
            setButton(state: 1)
        case 2:
            setButton(state: 2)
        default:
            break
        }
    }
    
    func setButton(state: Int) {
        for subview in self.scrollView.subviews {
            if subview.tag == 1 {
                if let rollcall = subview as? RollCallUIView {
                    for subsubview in rollcall.subviews {
                        if subsubview.tag == 2 {
                            if let mysubview = subsubview as? StudentButton{
                                mysubview.segmentState = state
                            }
                        }
                    }
                }
            }
        }
    }
    
}
