//
//  LoginViewController.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

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
    
    func Login(_user:String, _psw:String)
    {
        LoginService.sharedInstance.loginWithCompletionHandler(username: _user, password: _psw) { (error) -> Void in
            if (error == nil) {
                print(LoginService.sharedInstance.getToken())
            }
        }
        
    }
    
}
