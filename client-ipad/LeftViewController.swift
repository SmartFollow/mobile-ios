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
}

class LeftViewController: UIViewController {
    
    let menus = ["Profile", "Cours", "Messagerie", "Paramètres", "Déconnexion"]
    var chatViewController: UIViewController! = nil
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewController = storyboard.instantiateViewController(withIdentifier: "MessagerieViewController") as! MessagerieViewController
        self.chatViewController = UINavigationController(rootViewController: chatViewController)
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
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        case .Courses:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true)
        }
    }
}

extension LeftViewController: UITableViewDelegate {
    
}
