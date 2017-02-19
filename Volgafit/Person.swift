//
//  Person.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private Long id;
//private String firstName;
//private String lastName;
//private String photo;
//private Date birthDate;
//private String street;
//private String city;
//private String country;
//private String zipCode;
//private String phone;
//private String email;
//private List<String> social;

class Person: JSONDecodable, PrettyPrintable {
    let id: Int?
    let firstName: String
    let lastName: String
    let imagePath: String?
    let birthDate: Date?
    let street: String?
    let city: String?
    let country: String?
    let zipCode: String?
    let phone: String?
    let email: String?
    let social: [String]?
    
    init(id: Int? = nil, firstName: String, lastName: String, imagePath: String?, birthDate: Date?, street: String?, city: String?, country: String?, zipCode: String?, phone: String?, email: String?, social: [String]?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.imagePath = imagePath
        self.birthDate = birthDate
        self.street = street
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.phone = phone
        self.email = email
        self.social = social
    }

    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String
            else {
                return nil
        }
            
        let imagePath = json["imagePath"] as? String
        let birthDate = json["birthDate"] as? Date
        let street = json["street"] as? String
        let city = json["city"] as? String
        let country = json["country"] as? String
        let zipCode = json["zipCode"] as? String
        let phone = json["phone"] as? String
        let email = json["email"] as? String
        let social = json["social"] as? [String]
        
        self.init(id: id, firstName: firstName, lastName: lastName, imagePath: imagePath, birthDate: birthDate, street: street, city: city, country: country, zipCode: zipCode, phone: phone, email: email, social: social)
    }
}
