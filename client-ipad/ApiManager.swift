//
//  ApiManager.swift
//  client-ipad
//
//  Created by Alexandre Page on 15/06/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation
import OHHTTPStubs

class ApiManager: NSObject {
  
  static let sharedInstance = ApiManager()
  
  public func fetch(endPoint: String, method: String = "GET", parameters: String = "", json: [String: Any] = [:], completion: @escaping (_ result: Data?) -> Void) {
    #if DEBUG
      stubbing()
    #endif
    
    let url = URL(string: ConnectionSettings.apiBaseUrl + endPoint )
    var request = URLRequest(url: (url as URL?)!)
    request.httpMethod = method
    if json.first != nil {
      let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
      request.httpBody = jsonData
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    } else {
      request.httpBody = parameters.data(using: String.Encoding.utf8)
    }
    
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
  
  func stubbing() {
    stub(condition: isPath("/api/student-classes/3/students")) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("user-profile.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type":"application/json"]
      )
    }
    
    stub(condition: isPath("/api/evaluations/5/absences")) { request in
      return OHHTTPStubsResponse(
        fileAtPath: OHPathForFile("postAbsence.json", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/json"]
        ).requestTime(0.5, responseTime: 1.0)
    }
  }
}


