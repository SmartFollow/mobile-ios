//
//  RecipientCell.swift
//  client-ipad
//
//  Created by Alexandre Page on 17/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class RecipientCell: UITableViewCell {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var picture: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      self.contentView.backgroundColor = UIColor.gray
    } else {
      self.contentView.backgroundColor = UIColor.white
    }
    // Configure the view for the selected state
  }
  
}
