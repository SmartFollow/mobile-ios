//
//  CaseCalendar.swift
//  client-ipad
//
//  Created by Alexandre Page on 01/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class CasePlanning: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = 42
        self.backgroundColor = UIColor.red
        print(" -> \(self.bounds.width) \(self.bounds.height)")
        let subject: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        subject.text = "Réservation"
        subject.textAlignment = .center
        self.addSubview(subject)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
