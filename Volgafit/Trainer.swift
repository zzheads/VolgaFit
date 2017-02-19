//
//  Trainer.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private String speciality;
//private String resume;
//private List<Workout> workouts;

class Trainer: Person {
    let speciality: String?
    let resume: String?
    let workouts: [Workout]?
    
    init(id: Int? = nil, firstName: String, lastName: String, imagePath: String?, birthDate: Date?, street: String?, city: String?, country: String?, zipCode: String?, phone: String?, email: String?, social: [String]?, speciality: String?, resume: String?, workouts: [Workout]?) {
        self.speciality = speciality
        self.resume = resume
        self.workouts = workouts
        super.init(id: id, firstName: firstName, lastName: lastName, imagePath: imagePath, birthDate: birthDate, street: street, city: city, country: country, zipCode: zipCode, phone: phone, email: email, social: social)
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
        let speciality = json["speciality"] as? String
        let resume = json["resume"] as? String
        var workouts: [Workout]? = nil
        if let workoutsJson = json["workouts"] as? [JSON] {
            workouts = [Workout](with: workoutsJson)
        }
        
        self.init(id: id, firstName: firstName, lastName: lastName, imagePath: imagePath, birthDate: birthDate, street: street, city: city, country: country, zipCode: zipCode, phone: phone, email: email, social: social, speciality: speciality, resume: resume, workouts: workouts)
    }
}
