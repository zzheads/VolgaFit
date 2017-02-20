//
//  Profile.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

class Profile: JSONDecodable {
    let id: Int
    let user: User
    let firstName: String
    let lastName: String
    let height: Double?
    let weight: Double?
    let imagePath: String?
    let birthDate: Date?
    let street: String?
    let city: String?
    let country: String?
    let zipCode: String?
    let phone: String?
    let social: [String]?
    let trainerOf: [Workout]?
    let clientOf: [Workout]?

    init(id: Int, user: User, firstName: String, lastName: String, height: Double?, weight: Double?, imagePath: String?, birthDate: Date?, street: String?,
         city: String?, country: String?, zipCode: String?, phone: String?, social: [String]?, trainerOf: [Workout]?, clientOf: [Workout]?) {
        self.id = id
        self.user = user
        self.firstName = firstName
        self.lastName = lastName
        self.height = height
        self.weight = weight
        self.imagePath = imagePath
        self.birthDate = birthDate
        self.street = street
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.phone = phone
        self.social = social
        self.trainerOf = trainerOf
        self.clientOf = clientOf
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
        let height = json["height"] as? Double
        let weight = json["weight"] as? Double
        let imagePath = json["imagePath"] as? String
        let birthDate = json["birthDate"] as? Date
        let street = json["street"] as? String
        let city = json["city"] as? String
        let country = json["country"] as? String
        let zipCode = json["zipCode"] as? String
        let phone = json["phone"] as? String
        let social = json["social"] as? [String]
        var trainerOf: [Workout]? = nil
        var clientOf: [Workout]? = nil
        if let trainerOfJson = json["trainerOf"] as? JSONArray {
            trainerOf = [Workout](with: trainerOfJson)
        }
        if let clientOfJson = json["clientOf"] as? JSONArray {
            clientOf = [Workout](with: clientOfJson)
        }
        self.init(id: id, user: user, firstName: firstName, lastName: lastName, height: height, weight: weight, imagePath: imagePath, birthDate: birthDate, street: street,
                  city: city, country: country, zipCode: zipCode, phone: phone, social: social, trainerOf: trainerOf, clientOf: clientOf)
    }
    
}
