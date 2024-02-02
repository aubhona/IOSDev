//
//  Request.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

import Foundation

struct Request {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case options = "OPTIONS"
    }
    
    var endpoint: Endpoint
    var method: RequestMethod
    let parameters: RequestParameters?
    let body: Data?
    
    init(
        endpoint: Endpoint,
        method: Request.RequestMethod = .get,
        parameters: RequestParameters? = nil,
        body: Data? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.body = body
    }
}
