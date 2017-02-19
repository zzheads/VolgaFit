//
//  Endpoint.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import Alamofire

protocol Endpoint {
    static var USER: String { get }
    static var PASSWORD: String { get }
    
    var baseUrl: URL { get }
    var path: String { get }
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var request: DataRequest { get }
    var id: Int? { get }
    var body: JSONDecodable? { get }
}

extension Endpoint {
    var url: URL {
        return URL(string: self.path, relativeTo: self.baseUrl)!
    }
    
    var request: DataRequest {
        let request = Alamofire.request(self.url, method: self.method, parameters: self.parameters, encoding: self.encoding, headers: self.headers)
        print("url: \(url.description), method: \(method.rawValue), parameters: \(parameters)")
        return request
    }
    
    var headers: HTTPHeaders? {
        var headers = ["Accept": "application/json","Content-Type": "application/json"]
        if let authorizationHeader = Request.authorizationHeader(user: Self.USER, password: Self.PASSWORD) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        return headers
    }
    
    var parameters: Parameters? {
        return self.body?.json
    }    
}
