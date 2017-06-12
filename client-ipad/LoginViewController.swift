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
    
    
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    enum MyError : Error {
        case RuntimeError(String)
    }
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let username = _username.text
        let password = _password.text
        
        Login(_user: username!, _psw: password!)
        
    }
    
    func loadProfile() {
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        //UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        //leftViewController.mainViewController = nvc
        
        //let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        //let slideMenuController = SlideMenuController(mainViewController: nvc, leftViewController: leftViewController)
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
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
