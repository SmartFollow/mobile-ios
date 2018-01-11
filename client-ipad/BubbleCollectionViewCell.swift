//
//  BubbleCollectionViewCell.swift
//  client-ipad
//
//  Created by Alexandre Page on 21/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class BubbleCollectionViewCell: UICollectionViewCell {
    
  let textView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = UIColor.clear
    textView.isScrollEnabled = false
    textView.isEditable = false
    textView.font = UIFont.systemFont(ofSize: 18)
    return textView
  }()
  
  let textBubbleView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    view.layer.cornerRadius = 15
    view.layer.masksToBounds = true
    return view
  }()
  
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  
  func setup(message: Message, avatar: UIImage) {
    
    let blue = UIColor(red:0.09, green:0.50, blue:0.96, alpha:1.0)

    profileImageView.image = avatar
    
    if Conversation.isMessageFromUser(message: message) {
      self.textView.textColor = UIColor.white
      self.textBubbleView.backgroundColor = blue
      self.profileImageView.isHidden = true
    } else {
      self.profileImageView.isHidden = false
      self.textView.textColor = UIColor.black
      self.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    self.textView.text = message.text
    self.textView.sizeToFit()
    
    addSubview(textBubbleView)
    addSubview(textView)
    addSubview(profileImageView)
    let viewDic = ["v0": profileImageView]
  
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(30)]", options: [], metrics: nil, views: viewDic))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]|", options: [], metrics: nil, views: viewDic))
  }
  
}
