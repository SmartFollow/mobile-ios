//
//  MessagerieViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 12/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift

class ChatViewController : UITableViewController {
    
    @IBOutlet weak var participant: UILabel!
    var conversations: [Conversation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "new-message")!)
        
        let semaphore = DispatchSemaphore(value: 0)
        ApiManager.sharedInstance.fetch(endPoint: "/api/conversations") { (result: Data?) in
            self.conversations = ApiManager.parseListConversation(result: result!)
            semaphore.signal()
        }
        semaphore.wait()
    }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwitchToConversation" {
            let raw = sender as? Int
            if let destinationVC = segue.destination as? ConversationCollectionViewController {
                destinationVC.conversation = self.conversations![raw!]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.conversations?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        let participants = self.conversations![indexPath.row].getParticipantsName()
        cell.participants.text = participants.joined(separator: " ")
        cell.picture.image = UIImage(named: "default-avatar.png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SwitchToConversation", sender: indexPath.row)
    }
    
}


