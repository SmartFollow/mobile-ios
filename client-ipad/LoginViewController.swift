//
//  LoginViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LoginViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var _password: UITextField!
  @IBOutlet weak var _username: UITextField!
  @IBOutlet weak var _loginButton: UIButton!
  
  override func viewDidLoad() {
    let regularFont:UIFont = UIFont(name: "Lato-light", size: 50)!
    let boldFont:UIFont = UIFont(name: "Lato-bold", size: 50)!
    
    //Making dictionaries of fonts that will be passed as an attribute
    
    let firstDict:NSDictionary = NSDictionary(object: regularFont, forKey:
      NSFontAttributeName as NSCopying)
    let boldDict:NSDictionary = NSDictionary(object: boldFont, forKey:
      NSFontAttributeName as NSCopying)
    
    var firstText = "Follow"
    let attributedString = NSMutableAttributedString(string: firstText,
                                                     attributes: firstDict as? [String : AnyObject])
    
    let boldText  = "Smart"
    let boldString = NSMutableAttributedString(string:boldText,
                                               attributes:boldDict as? [String : AnyObject])
    
    boldString.append(attributedString)
    
    titleLabel.textAlignment = .center
    titleLabel.attributedText = boldString
  }
  
  @IBAction func loginButton(_ sender: Any) {
    
    let username = _username.text
    let password = _password.text
    
    Login(_user: username!, _psw: password!)
  }
  
  func loadProfile() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let sideBar = UIStoryboard(name: "Sidebar", bundle: nil)
    let bounds = UIScreen.main.bounds
    
    let mainViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
    let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
    let rightViewController = sideBar.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
    
    SlideMenuOptions.rightViewWidth = bounds.size.width
    
    let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
    
    let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController:  UINavigationController(rootViewController: rightViewController))
    slideMenuController.automaticallyAdjustsScrollViewInsets = true
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
    appDelegate.window?.rootViewController = slideMenuController
    appDelegate.window?.makeKeyAndVisible()
  }
  
  func Login(_user:String, _psw:String)
  {
    LoginService.sharedInstance.loginWithCompletionHandler(username: _user, password: _psw) { (error) -> Void in
      if (error == nil) {
        DispatchQueue.main.async(execute: { () -> Void in
          self.loadProfile()
        })
        
      } else {
        
        DispatchQueue.main.async(execute: { () -> Void in
          let alertController = UIAlertController(title: "Erreur", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
          alertController.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default,handler: nil))
          self.present(alertController, animated: true, completion: nil)
        })
        
      }
    }
    
  }
  
}
