//
//  Workout.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private Long id;
//private String title;
//private String description;
//private String place;
//private String image;
//private Date beginTime;
//private Date endTime;
//private Trainer trainer;
//private List<Client> clients;

struct Workout: JSONDecodable {
    let id: Int?
    let title: String
    let description: String?
    let place: String
    let imagePath: String?
    let beginTime: Date
    let endTime: Date
    let trainer: User
    let clients: [User]?

    init(id: Int? = nil, title: String, description: String?, place: String, imagePath: String?, beginTime: Date, endTime: Date, trainer: User, clients: [User]? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.place = place
        self.imagePath = imagePath
        self.beginTime = beginTime
        self.endTime = endTime
        self.trainer = trainer
        self.clients = clients
    }
    
    init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let place = json["place"] as? String,
            let beginTime = json["beginTime"] as? Date,
            let endTime = json["endTime"] as? Date,
            let trainerJson = json["trainer"] as? JSON,
            let trainer = User(with: trainerJson)
        else {
            return nil
        }
        let description = json["description"] as? String
        let imagePath = json["imagePath"] as? String
        var clients: [User]? = nil
        if let clientsJson = json["clients"] as? [JSON] {
            clients = [User](with: clientsJson)
        }
        self.init(id: id, title: title, description: description, place: place, imagePath: imagePath, beginTime: beginTime, endTime: endTime, trainer: trainer, clients: clients)
    }
}
