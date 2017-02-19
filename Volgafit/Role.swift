//
//  Role.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

class Role: JSONDecodable, PrettyPrintable {
    let id: Int?
    let name: String
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.init(id: id, name: name)
    }
}

extension Role: JSONCodeable {
    var json: JSON {
        return [
            "id": self.id as AnyObject,
            "name": self.name as AnyObject
        ]
    }
}
