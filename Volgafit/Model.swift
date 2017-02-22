//
//  Model.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private class Model {
//    private Map<String, String> endpoints = new HashMap<String, String>() {{
//    put("/api/info", "Информация о сервисе");
//    put("/api/model", "Информация о ресурсах сервиса");
//    put("/api/news", "Новости");
//    put("/api/workout", "Тренировки");
//    put("/api/trainer", "Тренеры");
//    put("/api/client", "Клиенты");
//    }};
//}


struct Model: JSONDecodable {
    let endpoints: [String: String]
    
    init?(with json: JSON) {
        guard
            let endpoints = json["endpoints"] as? [String: String]
            else {
                return nil
        }
        self.endpoints = endpoints
    }
}
