//
//  MessagerieViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 12/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift

class MessagerieViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
    }

}
