//
//  User.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

struct User: JSONDecodable {
    var id: Int?
    var username: String
    var password: String
    var email: String
    var enabled: Bool?
    var role: Role?
    var profile: Profile?
    var contact: Contact?
    var trainerOf: [Workout]?
    var clientOf: [Workout]?
    var imagePath: String?
    
    init(id: Int? = nil, username: String, password: String, email: String, enabled: Bool? = nil, role: Role? = nil, profile: Profile? = nil, contact: Contact? = nil, trainerOf: [Workout]? = nil, clientOf: [Workout]? = nil, imagePath: String? = nil) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.enabled = enabled
        self.role = role
        self.profile = profile
        self.contact = contact
        self.trainerOf = trainerOf
        self.clientOf = clientOf
        self.imagePath = imagePath
    }
    
    init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let username = json["username"] as? String,
            let password = json["password"] as? String,
            let email = json["email"] as? String,
            let enabled = json["enabled"] as? Bool,
            let roleJson = json["role"] as? JSON,
            let role = Role(with: roleJson)
            else {
                return nil
        }
        var profile: Profile? = nil
        if let profileJson = json["profile"] as? JSON {
            profile = Profile(with: profileJson)
        }
        var contact: Contact? = nil
        if let contactJson = json["contact"] as? JSON {
            contact = Contact(with: contactJson)
        }
        var trainerOf: [Workout]? = nil
        var clientOf: [Workout]? = nil
        if let trainerOfJson = json["trainerOf"] as? [JSON] {
            trainerOf = [Workout](with: trainerOfJson)
        }
        if let clientOfJson = json["clientOf"] as? [JSON] {
            clientOf = [Workout](with: clientOfJson)
        }
        let imagePath = json["imagePath"] as? String
        
        self.init(id: id, username: username, password: password, email: email, enabled: enabled, role: role, profile: profile, contact: contact, trainerOf: trainerOf, clientOf: clientOf, imagePath: imagePath)
    }
}
