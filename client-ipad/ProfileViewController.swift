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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
    profilePicture.asCircle(borderWidth: 5)
    ApiManager.sharedInstance.fetch(endPoint: "/users/profile") { (result: Data?) in
      self.saveInformationProfile(result: result)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func saveInformationProfile(result: Data?) -> Void {
    var taughtSubjectsArray = [Dictionary<String, Int>]()
    do {
      if let json = try JSONSerialization.jsonObject(with: result!, options: []) as? [String: Any] {
        if let firstName = json["firstname"], let lastName = json["lastname"],
          let email = json["email"] as? String {
          UserDefaults.standard.set(firstName, forKey: "firstName")
          UserDefaults.standard.set(lastName, forKey: "lastName")
          UserDefaults.standard.set(email, forKey: "email")
        }
        if let group = json["group"] as? [String: AnyObject] {
          if let groupId = group["id"], let groupName = group["name"] as? String {
            UserDefaults.standard.set(groupId, forKey: "groupId")
            UserDefaults.standard.set(groupName, forKey: "groupName")
          }
        }
        if let taughtSubjects = json["taught_subjects"] as? [[String: Any]] {
          for subject in taughtSubjects {
            if let id = subject["id"] as? Int,
              let levelId = subject["level_id"] as? Int {
              taughtSubjectsArray.append(["id": id, "levelId": levelId])
            }
          }
          UserDefaults.standard.set(taughtSubjectsArray, forKey: "taughtSubjects")
          let a = UserDefaults.standard.object(forKey: "taughtSubjects") as! [Dictionary<String, Int>]
          //                    for b in a {
          //                        print(b["id"]!)
          //                        print(b["levelId"]!)
          //                    }
        }
      }
      
    } catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    DispatchQueue.main.async(execute: { () -> Void in
      self.name.text = "\(UserDefaults.standard.value(forKey: "firstName")!) \(UserDefaults.standard.value(forKey: "lastName")!)"
      self.group.text = "\(UserDefaults.standard.value(forKey: "groupName")!)"
    })
  }
  
}

