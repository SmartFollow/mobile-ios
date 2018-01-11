//
//  ProfilePictureView.swift
//  client-ipad
//
//  Created by Alexandre Page on 12/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class SideBarView: UIView {
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var background: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.profilePicture.asCircle()
  }
}
