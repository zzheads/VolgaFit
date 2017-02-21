//
//  Profile.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

enum Sex: String {
    case male
    case female
}

class Profile: JSONDecodable {
    let id: Int
    let user: User
    let firstName: String
    let lastName: String
    let sex: Sex?
    let height: Double?
    let weight: Double?
    let birthDate: Date?

    init(id: Int, user: User, firstName: String, lastName: String, sex: Sex?, height: Double?, weight: Double?, birthDate: Date?) {
        self.id = id
        self.user = user
        self.firstName = firstName
        self.lastName = lastName
        self.sex = sex
        self.height = height
        self.weight = weight
        self.birthDate = birthDate
    }
    
    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let userJson = json["user"] as? JSON,
            let user = User(with: userJson),
            let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String
        else {
            return nil
        }
        var sex: Sex? = nil
        if let sexValue = json["sex"] as? String {
            sex = Sex(rawValue: sexValue)
        }
        let height = json["height"] as? Double
        let weight = json["weight"] as? Double
        let birthDate = json["birthDate"] as? Date
        self.init(id: id, user: user, firstName: firstName, lastName: lastName, sex: sex, height: height, weight: weight, birthDate: birthDate)
    }
}

extension Profile {
    var shouldSkipFields: [String]? {
        return [
            "profile"
        ]
    }
}
