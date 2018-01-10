//
//  StudentCell.swift
//  client-ipad
//
//  Created by Alexandre Page on 25/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

  @IBOutlet weak var studentName: UILabel!
  @IBOutlet weak var studentPicture: UIImageView!
  @IBOutlet weak var criterion1: UILabel!
  @IBOutlet weak var criterion2: UILabel!
  @IBOutlet weak var criterion3: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
