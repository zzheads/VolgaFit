//
//  Contact.swift
//  Volgafit
//
//  Created by Alexey Papin on 21.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private Long id;
//private UserDto user;
//private String street;
//private String city;
//private String country;
//private String zipCode;
//private String phone;
//private String[] social;

class Contact: JSONDecodable {
    let id: Int
    let user: User
    var street: String
    var city: String
    var country: String
    var zipCode: String
    var phone: String
    var social: [String]
    
    init(id: Int, user: User, street: String, city: String, country: String, zipCode: String, phone: String, social: [String]) {
        self.id = id
        self.user = user
        self.street = street
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.phone = phone
        self.social = social
    }

    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let userJson = json["user"] as? JSON,
            let user = User(with: userJson),
            let street = json["street"] as? String,
            let city = json["city"] as? String,
            let country = json["country"] as? String,
            let zipCode = json["zipCode"] as? String,
            let phone = json["phone"] as? String,
            let social = json["social"] as? [String]
            else {
                return nil
        }
        self.init(id: id, user: user, street: street, city: city, country: country, zipCode: zipCode, phone: phone, social: social)
    }
    
}
