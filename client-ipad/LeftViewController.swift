//
//  LeftViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 10/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation
import UIKit

enum Menu : Int {
  case Profile = 0
  case Courses
  case Chat
  case Planning
  case Settings
  case Logout
}

class LeftViewController: UIViewController {
  
  let menus = ["Profile", "Cours", "Messagerie", "Planning", "Paramètres", "Déconnexion"]
  var chatViewController: UIViewController!
  var profileViewController: UIViewController!
  var coursesViewController: UIViewController!
  var planningViewController: UIViewController!
  var sideBarView: SideBarView!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let coursesStoryboard = UIStoryboard(name: "Courses", bundle: nil)
    let planningStoryBoard = UIStoryboard(name: "Planning", bundle: nil)
    let messagingStoryBoard = UIStoryboard(name: "Messaging", bundle: nil)
    
    let chatViewController = messagingStoryBoard.instantiateViewController(withIdentifier: "ChatViewController")
    self.chatViewController = UINavigationController(rootViewController: chatViewController)
    
    let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
    self.profileViewController = UINavigationController(rootViewController: profileViewController)
    
    let coursesViewController = coursesStoryboard.instantiateViewController(withIdentifier: "LessonViewController")
    self.coursesViewController = UINavigationController(rootViewController: coursesViewController)
    
    let planningViewController = planningStoryBoard.instantiateViewController(withIdentifier: "PlanningViewController")
    self.planningViewController = UINavigationController(rootViewController: planningViewController)
    
    self.sideBarView = Bundle.main.loadNibNamed("SideBarView", owner: nil, options: nil)?.first as? SideBarView
    self.view.addSubview(self.sideBarView)
    
    self.tableView.tableFooterView = UIView()
    
    self.tableView.backgroundColor = UIColor.init(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
  }
  
  func Logout() {
    LoginService.sharedInstance.signOut()
    let controllerId = LoginService.sharedInstance.isLoggedIn() ? "ProfileViewController" : "LoginViewController";
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId) as UIViewController
    self.present(initViewController, animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
    self.view.layoutIfNeeded()
  }
  
}

extension LeftViewController: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menus.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    cell.backgroundColor = UIColor.clear
    cell.textLabel?.textColor = UIColor.white
    cell.textLabel?.text = menus[indexPath.row]
    return cell
  }
}

extension LeftViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let selection = Menu(rawValue: indexPath.row) {
      switch selection {
      case .Chat:
        self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
      case .Profile:
        self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
      case .Courses:
        self.slideMenuController()?.changeMainViewController(self.coursesViewController, close: true)
      case .Settings:
        self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
      case .Planning:
        self.slideMenuController()?.changeMainViewController(self.planningViewController, close: true)
      case .Logout:
        self.Logout()
      }
    }
  }
}
