//
//  RequestService.swift
//  client-ipad
//
//  Created by Alexandre Page on 24/05/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import Foundation


class RequestService {
    var _url: String
    static var _endpoint: String = "http://api.dev.smartfollow.lan/"
    var _httpMethod: String
    var grantType = "password"
    var clientSecret = "sxeAxu3CipHly4kZ7NVzcpSgO7xVXqlJs6twFQaL"
    var clientId = "2"
    var userName = "stephany.funk@example.com"
    var password = "secret"
    
    init(requestType: String, url: String) {
        _httpMethod = requestType
        _url = url
    }
}
