//
//  ConversationCollectionViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 20/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ConversationCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  private let reuseIdentifier = "BubbleCell"
  var conversation: Conversation!
  var bottomConstraint: NSLayoutConstraint?
  
  let messageInputContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    return view
  }()
  
  let inputTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter message..."
    return textField
  }()
  
  lazy var sendButton: UIButton = {
    let button = UIButton(type: UIButtonType.system)
    let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
    button.setTitle("Envoyer", for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = self.conversation.subject
    if self.conversation.messages.count == 0 {
      let semaphore = DispatchSemaphore(value: 0)
      ApiManager.sharedInstance.fetch(endPoint: "/api/conversations/\(conversation.id)") { (result: Data?) in
        ApiManager.parseMessages(result: result, conversation: self.conversation)
        semaphore.signal()
      }
      semaphore.wait()
    }
    
    collectionView?.register(BubbleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    view.addSubview(messageInputContainerView)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
    view.addConstraintsWithFormat(format: "V:[v0(48)]", views: messageInputContainerView)
    setupInputComponent()
    
    
    bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    view.addConstraint(bottomConstraint!)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let count = self.conversation.messages.count
    let indexPath = IndexPath(item: count, section: 0)
    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
  }
  
  @objc func back(_sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let sideBar = UIStoryboard(name: "Sidebar", bundle: nil)
    let messaging = UIStoryboard(name: "Messaging", bundle: nil)
    let bounds = UIScreen.main.bounds
    
  
    let chatViewController = messaging.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
    let rightViewController = sideBar.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
    let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
    SlideMenuOptions.rightViewWidth = bounds.size.width
    
    let nvc: UINavigationController = UINavigationController(rootViewController: chatViewController)
    let rightNaviguationController = UINavigationController(rootViewController: rightViewController)
    
    let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController:  rightNaviguationController)
    self.present(slideMenuController, animated: true, completion: nil)
  }
  
  @objc private func handleSend() {
    let item = self.conversation.messages.count
    let insertionIndexPath = IndexPath(item: item, section: 0)
    let index = IndexPath(item: item + 1, section: 0)
    
    ApiManager.sharedInstance.fetch(endPoint: "/api/messages", method: "POST", parameters: "conversation_id=\(self.conversation.id)&content=\(inputTextField.text!)") { (result: Data?) in
      DispatchQueue.main.async {
        let message = ApiManager.parseMessageSent(result: result)
        self.conversation.messages.append(message!)
        self.collectionView?.insertItems(at: [insertionIndexPath])
        self.collectionView?.scrollToItem(at: index, at: .bottom, animated: true)
        self.inputTextField.text = nil
      }
    }
    
  }
  
  @objc private func handleKeyboardNotification(notification: NSNotification) {
    if let userInfo = notification.userInfo {
      
      let isKeyboardShowing = notification.name == .UIKeyboardWillShow
      let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height: 0
      
      UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
        self.view.layoutIfNeeded()
      }, completion: { (completed) in
        if isKeyboardShowing {
          let indexPath = IndexPath(item: self.conversation.messages.count, section: 0)
          self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
      })
    }
  }
  
  private func setupInputComponent() {
    
    let topBorderView = UIView()
    topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    
    messageInputContainerView.addSubview(inputTextField)
    messageInputContainerView.addSubview(sendButton)
    messageInputContainerView.addSubview(topBorderView)
    
    messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]|", views: inputTextField, sendButton)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
    
    messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.6)]", views: topBorderView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    inputTextField.endEditing(true)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = self.conversation.messages.count as Int? {
      return count + 1
    }
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BubbleCollectionViewCell
    
    if let count = self.conversation.messages.count as Int?, indexPath.item < count {
      let message = self.conversation.messages[indexPath.item]
      let picture = self.conversation.getParticipantAvatar(message: message)
      
      let size = CGSize(width: 250, height: 1000)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      let estimatedFrame = NSString(string: message.text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0)], context: nil)
      
      if !Conversation.isMessageFromUser(message: message) {
        cell.textView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        cell.textBubbleView.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
      } else {
        cell.textView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
        cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16 , y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
      }
      cell.setup(message: message, avatar: picture!)
    } else {
      cell.textView.frame = CGRect()
      cell.textBubbleView.frame = CGRect()
      cell.profileImageView.image = UIImage()
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if let count = self.conversation.messages.count as Int?, indexPath.item < count {
      let message = self.conversation.messages[indexPath.item].text
      let size = CGSize(width: 250, height: 1000)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      let estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0)], context: nil)
      return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    } else {
      return CGSize(width: view.frame.width, height: 48)
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
  }
  
}
