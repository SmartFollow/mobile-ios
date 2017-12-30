//
//  ViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var group: UILabel!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var mainView: UIView!
  
  var difficulties: StudentsInDifficultiesController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
    profilePicture.asCircle(borderWidth: 5)
    ApiManager.sharedInstance.fetch(endPoint: "/api/users/profile") { (result: Data?) in
      ApiManager.saveInformationProfile(result: result)
      DispatchQueue.main.async(execute: { () -> Void in
        self.name.text = "\(UserDefaults.standard.value(forKey: "firstName")!) \(UserDefaults.standard.value(forKey: "lastName")!)"
        self.group.text = "\(UserDefaults.standard.value(forKey: "groupName")!)"
      })
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? StudentsInDifficultiesController {
      if let subview = mainView.viewWithRestorationTag(str: "DifficultiesWidget") {
        vc.height = subview.constraints.filter { $0.identifier == "Height" }.first!
      }
    }
  }
  
}

