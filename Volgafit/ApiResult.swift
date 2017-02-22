//
//  ApiResult.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

class ApiResult: JSONDecodable {
    let success: Bool
    let message: String
    
    init(success: Bool, message: String) {
        self.success = success
        self.message = message
    }
    
    required convenience init?(with json: JSON) {
        guard
            let success = json["success"] as? Bool,
            let message = json["message"] as? String
            else {
                return nil
        }
        self.init(success: success, message: message)
    }
}
