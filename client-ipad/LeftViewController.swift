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
    case Settings
    case Logout
}

class LeftViewController: UIViewController {
    
    let menus = ["Profile", "Cours", "Messagerie", "Paramètres", "Déconnexion"]
    var chatViewController: UIViewController!
    var profileViewController: UIViewController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
        self.chatViewController = UINavigationController(rootViewController: chatViewController)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        self.profileViewController = UINavigationController(rootViewController: profileViewController)
    
    }
    
     func Logout() {
        LoginService.sharedInstance.signOut()
        
        let controllerId = LoginService.sharedInstance.isLoggedIn() ? "ProfileViewController" : "LoginViewController";
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId) as UIViewController
        self.present(initViewController, animated: true, completion: nil)
    }
    
}

extension LeftViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = Menu(rawValue: indexPath.row)
        switch selection! {
        case .Chat:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        case .Profile:
            self.slideMenuController()?.changeMainViewController(self.profileViewController, close: true)
        case .Courses:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        case .Logout:
            self.Logout()
        }
    }
}

extension LeftViewController: UITableViewDelegate {
    
}
