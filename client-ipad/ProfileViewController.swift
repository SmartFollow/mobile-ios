//
//  ViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        profilePicture.asCircle(borderWidth: 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

