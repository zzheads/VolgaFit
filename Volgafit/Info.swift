//
//  Info.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private String artifact = "VolgoFit API";
//private String version = "1.0.0";
//private String lastModified = "13/02/2017";
//private String createdBy = "Alexey Papin";
//private String poweredBy[] = {"JavaSpring", "MySQL"};

class Info: JSONDecodable {
    let artifact: String
    let version: String
    let lastModified: String
    let createdBy: String
    let poweredBy: [String]
    
    init(artifact: String, version: String, lastModified: String, createdBy: String, poweredBy: [String]) {
        self.artifact = artifact
        self.version = version
        self.lastModified = lastModified
        self.createdBy = createdBy
        self.poweredBy = poweredBy
    }
    
    required convenience init?(with json: JSON) {
        guard
            let artifact = json["artifact"] as? String,
            let version = json["version"] as? String,
            let lastModified = json["lastModified"] as? String,
            let createdBy = json["createdBy"] as? String,
            let poweredBy = json["poweredBy"] as? [String]
            else {
                return nil
        }
        self.init(artifact: artifact, version: version, lastModified: lastModified, createdBy: createdBy, poweredBy: poweredBy)
    }
}
