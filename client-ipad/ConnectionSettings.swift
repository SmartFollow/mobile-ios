//
//  ConnectionSettings.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

public struct ConnectionSettings {
    
    static let clientId = "2"
    static let clientSecret = "j3YxK56keDaber2XzbQSV1qBKwF5iPP2eAMQSq8F"
    static let grantType = "password"
    static var apiBaseUrl = "http://api.dev.smartfollow.lan"
    
    public static func apiURLWithPathComponents(components: String) -> NSURL {
        let baseUrl = URL(string: ConnectionSettings.apiBaseUrl)
        let APIUrl = NSURL(string: components, relativeTo: baseUrl)
        
        return APIUrl!
    }
    
    public static func InitialiseParameter() -> String {
        return "grant_type=\(grantType)&client_id=\(clientId)&client_secret=\(clientSecret)&"
    }
}

