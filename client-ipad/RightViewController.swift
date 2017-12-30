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
  var selectedCells:[Int] = []
  var users = [User]()
  var conversations: [Conversation]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.slideMenuController()?.removeRightGestures()
    
    let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel(_:)))
    self.navigationItem.leftBarButtonItem = button
    
    let semaphore = DispatchSemaphore(value: 0)
    ApiManager.sharedInstance.fetch(endPoint: "/api/users") { (result: Data?) in
      self.users = ApiManager.parseAllUsers(result: result)
      ApiManager.sharedInstance.fetch(endPoint: "/api/conversations") { (result: Data?) in
        self.conversations = ApiManager.parseListConversation(result: result!)
        semaphore.signal()
      }
    }
    semaphore.wait()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.allowsMultipleSelection = true
    
    let ok = UIBarButtonItem(title: "Suivant", style: .plain, target: self, action: #selector(fctok))
    self.navigationItem.rightBarButtonItem = ok
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func cancel(_ sender: Any) {
    self.slideMenuController()?.closeRight()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SwitchToConversation" {
      if let destinationVC = segue.destination as? ConversationCollectionViewController {
        destinationVC.conversation = sender as? Conversation
      }
    }
  }
  
  func fctok(_ sender: Any) {
    if let selectedIndexPath = tableView.indexPathsForSelectedRows {
      if let selectedUsers = User.getUsers(users: users, selections: selectedIndexPath) {
        if let conversation = Conversation.getConversation(conversations: self.conversations!, users: selectedUsers) {
          self.conversations?.append(conversation)
          DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Messaging", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationCollectionViewController
            controller.conversation = conversation
            let navigationController = UINavigationController(rootViewController: controller)
            let button = UIBarButtonItem(title: "Back", style: .plain, target: controller, action: #selector(ConversationCollectionViewController.back))
            navigationController.topViewController?.navigationItem.leftBarButtonItem = button
            self.present(navigationController, animated: true, completion: nil)
          }
        } else {
          var i = 0
          var query = ""
          for user in selectedUsers {
            query.append("participants[\(i)]=\(user.id)&")
            i = i + 1
          }
          query.append("subject=Nouvelle Conversation")
          query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          ApiManager.sharedInstance.fetch(endPoint: "/api/conversations", method: "POST", parameters: query,
                                          completion: { (result: Data?) in
                                            let conversation = ApiManager.parseConversation(result: result)
                                            self.conversations?.append(conversation!)
                                            DispatchQueue.main.async {
                                              let storyboard = UIStoryboard(name: "Messaging", bundle: nil)
                                              let controller = storyboard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationCollectionViewController
                                              controller.conversation = conversation
                                              let navigationController = UINavigationController(rootViewController: controller)
                                              let button = UIBarButtonItem(title: "Back", style: .plain, target: controller, action: #selector(ConversationCollectionViewController.back))
                                              navigationController.topViewController?.navigationItem.leftBarButtonItem = button
                                              self.present(navigationController, animated: true, completion: nil)
                                            }
          })
        }
      }
    }

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
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: true)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(true, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}
