//
//  Profile.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

struct Profile: JSONDecodable {
    let id: Int
    let user: User
    let firstName: String
    let lastName: String
    let sex: String?
    let height: Double?
    let weight: Double?
    let birthDate: Date?

    init(id: Int, user: User, firstName: String, lastName: String, sex: String?, height: Double?, weight: Double?, birthDate: Date?) {
        self.id = id
        self.user = user
        self.firstName = firstName
        self.lastName = lastName
        self.sex = sex
        self.height = height
        self.weight = weight
        self.birthDate = birthDate
    }
    
    init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let userJson = json["user"] as? JSON,
            let user = User(with: userJson),
            let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String
        else {
            return nil
        }
        let sex = json["sex"] as? String
        let height = json["height"] as? Double
        let weight = json["weight"] as? Double
        let birthDate = json["birthDate"] as? Date
        self.init(id: id, user: user, firstName: firstName, lastName: lastName, sex: sex, height: height, weight: weight, birthDate: birthDate)
    }
}
