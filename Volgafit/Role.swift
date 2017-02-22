//
//  Role.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

struct Role: JSONDecodable {
    static let ADMIN = Role(name: "ADMIN")
    static let CLIENT = Role(name: "CLIENT")
    static let TRAINER = Role(name: "TRAINER")
    
    let id: Int?
    let name: String
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.init(id: id, name: name)
    }
}
