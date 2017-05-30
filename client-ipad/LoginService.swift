//
//  LoginService.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

public class LoginService : NSObject {
    
    
    internal var session:URLSession!
    private var tokenInfo:OAuthInfo!
    
    
    struct OAuthInfo {
        var accessToken: String!
        var tokenExpiresIn: Double!
        var refreshToken: String!
        var tokenType: String!
        var tokenExpiresAt: Date!
        
        
        init(tokenType: String, tokenExpiresIn: Double, refreshToken: String, accessToken: String, tokenExpiresAt: Date) {
            
            self.tokenExpiresAt = tokenExpiresAt
            self.tokenExpiresIn = tokenExpiresIn
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.tokenType = tokenType
            
            UserDefaults.standard.set(self.tokenExpiresIn, forKey: "tokenExpiresIn")
            UserDefaults.standard.set(self.accessToken, forKey: "accessToken")
            UserDefaults.standard.set(self.refreshToken, forKey: "refreshToken")
            UserDefaults.standard.set(self.tokenExpiresAt, forKey: "tokenExpiresAt") // Useless for now
    
        }
        
        init() {
            if let tokenExpiresIn = UserDefaults.standard.value(forKey: "tokenExpiresIn") as? Double {
                self.tokenExpiresIn = tokenExpiresIn
            }
            if let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String {
                self.accessToken = accessToken
            }
            if let refreshToken = UserDefaults.standard.value(forKey: "refreshToken") as? String {
                self.refreshToken = refreshToken
            }
            if let tokenExpiresAt = UserDefaults.standard.value(forKey: "tokenExpiresAt") as? Date {
                self.tokenExpiresAt = tokenExpiresAt
            }
        }
        
        func signOut() -> () {
            UserDefaults.standard.removeObject(forKey: "tokenExpiresIn")
            UserDefaults.standard.removeObject(forKey: "accessToken")
            UserDefaults.standard.removeObject(forKey: "refreshToken")
            UserDefaults.standard.removeObject(forKey: "tokenExpiresAt")
        }
    }
    
    class var sharedInstance : LoginService {
        struct Singleton {
            static let instance = LoginService()
        }
        
        if Singleton.instance.tokenInfo == nil {
            Singleton.instance.tokenInfo = OAuthInfo()
        }

        return Singleton.instance
    }
    
    
    override init() {
        let sessionConfig = URLSessionConfiguration.default
        
        super.init()
        
        session = URLSession(configuration: sessionConfig)
        
    }
    
    
    public func loginWithCompletionHandler(username: String, password: String, completionHandler: (( String?) -> Void)!) -> () {
        
        exchangeTokenForUserAccessTokenWithCompletionHandler(username: username, password: password) { (oauthInfo, error) -> () in
            if (error == nil) {
                
                self.tokenInfo = oauthInfo!
                completionHandler(nil)
            } else {
                
                self.tokenInfo = nil
                completionHandler(error)
            }
        }
    }
    
    public func signOut() {
        
        self.tokenInfo.signOut()
        self.tokenInfo = nil
    }
    
    public func isLoggedIn() -> Bool {
        var loggedIn:Bool = false
        let now = Date()
        if let info = self.tokenInfo {
            if let tokenExpiresAt = info.tokenExpiresAt {
                if tokenExpiresAt > now {
                    loggedIn = true
                }
            }
        }
        return loggedIn
    }
    
    public func getToken() -> String {
        if isLoggedIn() {
            return self.tokenInfo.accessToken
        }
        else {
            return ""
        }
    }
    
    
    
    private func exchangeTokenForUserAccessTokenWithCompletionHandler(username: String, password: String, completion: @escaping (OAuthInfo?, String?) -> ()) {
        
        let path = "/oauth/token"
        let url = ConnectionSettings.apiURLWithPathComponents(components: path)
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let params = ConnectionSettings.InitialiseParameter() + "username=\(username)&password=\(password)"
        
        request.httpBody = params.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data else {
                return
            }
            
            let json:Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch {
                return
            }
            
            guard let server_response = json as? NSDictionary else {
                return
            }
            
            if (server_response["error"] == nil) {
                let tokenType = server_response["token_type"] as? String
                let expiresIn = server_response["expires_in"] as? Double
                let accessToken = server_response["access_token"] as? String
                let refreshToken = server_response["refresh_token"] as? String
                
                let ExpiresAt = NSDate().addingTimeInterval(expiresIn!).timeIntervalSince1970
                let tokenExpiresAt = NSDate(timeIntervalSince1970: ExpiresAt) as Date
                
                let oauthInfo = OAuthInfo(tokenType: tokenType!, tokenExpiresIn: expiresIn!, refreshToken: refreshToken!, accessToken: accessToken!, tokenExpiresAt: tokenExpiresAt)
                completion(oauthInfo, nil)
                //print(OAuthInfo)
            }
            else {
                let err = server_response["message"] as! String?
                completion(OAuthInfo(), err)
            }
            
        })
        

        task.resume()
    }
    
}
