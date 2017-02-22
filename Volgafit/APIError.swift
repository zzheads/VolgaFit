//
//  APIError.swift
//  Traccar
//
//  Created by Alexey Papin on 08.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

let ZZHeadsAPIErrorDomain = "com.zzheads.APIErrors"

enum APIError: Error {
    case missingHTTPResponseError
    case unexpectedResponseError
    case httpResponseStatusCodeError(HTTPStatusCode)
    case serializationError
    
    var code: Int {
        switch self {
        case .missingHTTPResponseError: return 10
        case .unexpectedResponseError: return 20
        case .serializationError: return 30
        case .httpResponseStatusCodeError(let statusCode): return statusCode.rawValue
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .missingHTTPResponseError: return "Missing HTTP Response"
        case .unexpectedResponseError: return "Unexpected HTTP Response Error"
        case .serializationError: return "Bad data format, serialization error"
        case .httpResponseStatusCodeError(let statusCode): return "HTTP Response Error: \(statusCode.message)"
        }
    }
    
    var error: NSError {
        return NSError(domain: ZZHeadsAPIErrorDomain, code: self.code, userInfo: [NSLocalizedDescriptionKey: self.localizedDescription])
    }
}

struct ServerError: Error, JSONDecodable {
    let error: String
    let exception: String
    let message: String
    let path: String
    let status: Int
    let timestamp: UInt64
    
    init?(with json: JSON) {
        guard
            let error = json["error"] as? String,
            let exception = json["exception"] as? String,
            let message = json["message"] as? String,
            let path = json["path"] as? String,
            let status = json["status"] as? Int,
            let timestamp = json["timestamp"] as? UInt64
            else {
                return nil
        }
        self.error = error
        self.exception = exception
        self.message = message
        self.path = path
        self.status = status
        self.timestamp = timestamp
    }
}
