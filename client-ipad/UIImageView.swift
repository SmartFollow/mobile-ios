//
//  UIImageView.swift
//  client-ipad
//
//  Created by Alexandre Page on 15/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func asCircle(borderWidth: CGFloat = 1) {
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.white.cgColor
    }
}
