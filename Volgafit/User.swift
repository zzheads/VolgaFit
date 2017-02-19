//
//  User.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

class User: JSONDecodable, PrettyPrintable {
    let id: Int?
    let username: String
    let password: String
    let enabled: Bool?
    let role: Role?
    
    init(id: Int? = nil, username: String, password: String, enabled: Bool? = nil, role: Role? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.enabled = enabled
        self.role = role
    }
    
    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let username = json["username"] as? String,
            let password = json["password"] as? String,
            let enabled = json["enabled"] as? Bool,
            let roleJson = json["role"] as? JSON,
            let role = Role(with: roleJson)
            else {
                return nil
        }
        self.init(id: id, username: username, password: password, enabled: enabled, role: role)
    }
}

extension User: JSONCodeable {
    var json: JSON {
        return [
            "id": id as AnyObject,
            "username": username as AnyObject,
            "password": password as AnyObject,
            "enabled": enabled as AnyObject,
            "role": role?.json as AnyObject
        ]
    }
}
