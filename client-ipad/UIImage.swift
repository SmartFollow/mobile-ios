//
//  UIImage.swift
//  client-ipad
//
//  Created by Alexandre Page on 15/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension UIImage {
  
  convenience init(link: String) {
    let url = URL(string: link)
    let data = try? Data(contentsOf: url!)
    self.init(data: data!)!
  }
  
}
