//
//  ApiManager.swift
//  client-ipad
//
//  Created by Alexandre Page on 15/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    let baseUrl = "http://api.dev.smartfollow.lan"
    
    public func b(endPoint: String, completion: @escaping (_ result: Data?) -> Void) {
        let url = URL(string: baseUrl + endPoint )
        var request = URLRequest(url: (url as URL?)!)
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken")
        request.setValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
        
            if let response = response as? HTTPURLResponse {
                if response.statusCode / 100 != 2 {
                    return
                }
                print(data!)
                completion(data)
            }
        }
        task.resume()
    }
}
