//
//  ConversationCell.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

  @IBOutlet weak var picture: UIImageView!
  @IBOutlet weak var participants: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
