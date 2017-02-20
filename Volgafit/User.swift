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
    let email: String
    let enabled: Bool?
    let role: Role?
    let profile: Profile?
    
    init(id: Int? = nil, username: String, password: String, email: String, enabled: Bool? = nil, role: Role? = nil, profile: Profile? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.enabled = enabled
        self.role = role
        self.profile = profile
    }
    
    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let username = json["username"] as? String,
            let password = json["password"] as? String,
            let email = json["email"] as? String,
            let enabled = json["enabled"] as? Bool,
            let roleJson = json["role"] as? JSON,
            let role = Role(with: roleJson),
            let profileJson = json["profile"] as? JSON,
            let profile = Profile(with: profileJson)
            else {
                return nil
        }
        self.init(id: id, username: username, password: password, email: email, enabled: enabled, role: role, profile: profile)
    }
}
