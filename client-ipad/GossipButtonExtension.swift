//
//  GossipButtonExtension.swift
//  client-ipad
//
//  Created by Alexandre Page on 23/10/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

extension StudentButton {
    
    public func gossip() {
        let alert = reportStudent(title: "Remarque sur l'élève", message: "", preferredStyle: .alert)
        alert.show()
        //present(alert, animated: true, completion: nil)
    }
}
