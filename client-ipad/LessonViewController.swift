//
//  CoursesViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 02/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var profilPicture: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var recap: UITableView!
    var rollCallLessonView: RollCallUIView!
    var lesson: Lesson!
    var students: [Student]?
    var count: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let semaphore = DispatchSemaphore(value: 0)
        ApiManager.sharedInstance.fetch(endPoint: "/api/lessons/\(self.lesson.id)") { (result: Data?) in
            self.students = ApiManager.parseClassStudent(result: result)
            semaphore.signal()
        }
        semaphore.wait()
        
        setupDescriptionLabel()
        self.recap.isHidden = true
        profilPicture.asCircle()
        self.segmentControl.selectedSegmentIndex = 1
        displayStudent()
        self.recap.delegate = self
        self.recap.dataSource = self
    }
    
    func setupDescriptionLabel() {
        let title: [String] = ["Professeur", "Classe", "Cours", "Salle"]
        let label: [UILabel] = [self.teacherLabel, self.classLabel, self.lessonLabel, self.roomLabel]
        let content: [String] = ["alexandre.page@example.com", "\(self.lesson.studentClassName)", "\(self.lesson.subjectName)", "\(self.lesson.roomIdentifier)"]
        for (index, element) in title.enumerated() {
            let boldText  = element
            let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            let normalText = "\n\(content[index])"
            let normalString = NSMutableAttributedString(string:normalText)
            attributedString.append(normalString)
            label[index].attributedText = attributedString
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch self.segmentControl.selectedSegmentIndex {
        case 1, 2:
            showRollCall()
        case 3:
            showRecap()
        default:
            break
        }
    }
    
    func showRollCall() {
        DispatchQueue.main.async {
            self.scrollView.contentSize.height = 325.0 + (((CGFloat) (self.students!.count / 2) * (400.0)) - 50.0)
        }
        self.recap.isHidden = true
        for view in self.scrollView.subviews {
            if view.tag == RollCallUIView.tagView {
                view.isHidden = false
            }
        }
    }
    
    func showRecap() {
        DispatchQueue.main.async {
            self.scrollView.contentSize.height = self.recap.frame.origin.y + self.recap.bounds.size.height
        }
        self.recap.isHidden = false
        for view in self.scrollView.subviews {
            if view.tag == RollCallUIView.tagView {
                view.isHidden = true
            }
        }
    }
    
    func displayStudent() {
        
        let segmentPosition = self.segmentControl.frame.origin.y + self.segmentControl.frame.height
        var position: Position = .Left
        var raw = segmentPosition + 50.0
        var view: RollCallUIView
        let width =  self.view.bounds.size.width
        let height = self.view.bounds.size.height
        let count = self.students!.count % 3 == 0 ? self.students!.count / 3 : (self.students!.count / 3) + 1
        let heightWithStudent = (CGFloat(count) * 250.0)

        for student in self.students! {
            switch position {
            case .Left:
                view = RollCallUIView(frame: CGRect(x: 50, y: Int(raw), width: 200, height: 250), student: student, lesson: self.lesson)
            case .Middle:
                view = RollCallUIView(frame: CGRect(x: Int((width / 2) - 100), y: Int(raw), width: 200, height: 250), student: student, lesson: self.lesson)
            case .Right:
                view = RollCallUIView(frame: CGRect(x: Int(width - 200 - 50), y: Int(raw), width: 200, height: 250), student: student, lesson: self.lesson)
                raw += 300
            }
            self.scrollView.addSubview(view)
            position++
        }
        self.scrollView.contentSize.height = raw
    }
    
    @IBAction func onChange(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 1:
            showRollCall()
            setButton(state: 1)
        case 2:
            showRollCall()
            setButton(state: 2)
        case 3:
            showRecap()
            setButton(state: 3)
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
