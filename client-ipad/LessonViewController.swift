//
//  CoursesViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 02/07/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var roomLabel: UILabel!
  @IBOutlet weak var lessonLabel: UILabel!
  @IBOutlet weak var profilPicture: UIImageView!
  @IBOutlet weak var classLabel: UILabel!
  @IBOutlet weak var teacherLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var recap: UITableView!
  let avatar = UserDefaults.standard.object(forKey: "avatar") as! String
  var rollCallLessonView: RollCallUIView!
  var lesson: Lesson!
  var students: [Student]?
  var count: Int?
  var row: CGFloat = 0
  
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
    profilPicture.downloadedFrom(link: ConnectionSettings.apiBaseUrl + avatar)
    self.segmentControl.selectedSegmentIndex = 1
    displayStudent()
    self.recap.delegate = self
    self.recap.dataSource = self
  }
  
  func setupDescriptionLabel() {
    let title: [String] = ["Professeur", "Classe", "Cours", "Salle", "Date"]
    let label: [UILabel] = [self.teacherLabel, self.classLabel, self.lessonLabel, self.roomLabel, self.dateLabel]
    let email = UserDefaults.standard.object(forKey: "email") as! String
    let content: [String] = ["\n\(email)", "\n\(self.lesson.studentClassName)", "\n\(self.lesson.subjectName)", "\n\(self.lesson.roomIdentifier)", " \(self.lesson.getTimeStart())"]
    for (index, element) in title.enumerated() {
      let boldText = element
      let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
      let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
      let normalText = "\(content[index])"
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
    self.recap.isHidden = true
    for view in self.scrollView.subviews {
      if view.tag == RollCallUIView.tagView {
        view.isHidden = false
      }
    }
    DispatchQueue.main.async {
      self.scrollView.contentSize = CGSize(width: 768, height: self.row)
      let view = self.scrollView.viewWithRestorationTag(str: "MyView")
      let height = view?.constraints.filter { $0.identifier == "Height" }.first
      height?.constant = self.row
      view?.layoutIfNeeded()
    }
  }
  
  func showRecap() {
    let count = CGFloat(self.students!.count)
    let cell = self.recap.dequeueReusableCell(withIdentifier: "StudentCell") as! StudentCell
    let rowHeight = cell.bounds.height
    
    let constraint = self.recap.constraints.filter { $0.identifier == "Height" }.first
    DispatchQueue.main.async {
      let view = self.scrollView.viewWithRestorationTag(str: "MyView")
      let height = view?.constraints.filter { $0.identifier == "Height" }.first
      height?.constant = self.recap.frame.origin.y + (count * rowHeight)
      view?.layoutIfNeeded()
      self.recap.layoutIfNeeded()
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
    let adjust = self.students!.count % 3 != 0 ? true : false
    
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
    if (adjust) {
      raw += 300
    }
    self.row = raw
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
