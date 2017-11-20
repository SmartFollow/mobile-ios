//
//  RightViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var users = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.slideMenuController()?.removeLeftGestures()
    self.slideMenuController()?.removeRightGestures()
    
    let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel(_:)))
    
    self.navigationItem.leftBarButtonItem = button
    let semaphore = DispatchSemaphore(value: 0)
    ApiManager.sharedInstance.fetch(endPoint: "/api/users") { (result: Data?) in
      self.users = ApiManager.parseAllUsers(result: result)
      semaphore.signal()
    }
    semaphore.wait()
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func cancel(_ sender: Any) {
    self.slideMenuController()?.closeRight()
  }
  
}

extension RightViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientCell", for: indexPath) as! RecipientCell
    
    DispatchQueue.main.async {
      cell.picture.image = self.users[indexPath.row].avatar
      cell.name.text = "\(self.users[indexPath.row].firstName) \(self.users[indexPath.row].lastName)"
      cell.name.sizeToFit()
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "SwitchToConversation", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

}
