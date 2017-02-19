//
//  VolgofitEndpoint.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import Alamofire

enum VolgofitEndpoint: Endpoint {
    static let USER = "root"
    static let PASSWORD = "root" 
    
    case info
    case model
    case news(id: Int?, news: News?)
    case deleteNews(id: Int)
    case trainer(id: Int?, trainer: Trainer?)
    case deleteTrainer(id: Int)
    case client(id: Int?, client: Client?)
    case deleteClient(id: Int)
    case workout(id: Int?, client: Workout?)
    case deleteWorkout(id: Int)
    case user(id: Int?, user: User?)
    case deleteUser(id: Int)
    
    //var baseUrl: URL { return URL(string: "https://volgofit.herokuapp.com/api/")!}
    var baseUrl: URL { return URL(string: "http://localhost:8080/api/")!}
    
    var path: String {
        var path = ""
        switch self {
        case .info:                     path = "info"
        case .model:                    path = "model"
        case .news, .deleteNews:        path = "news"
        case .trainer, .deleteTrainer:  path = "trainer"
        case .client, .deleteClient:    path = "client"
        case .workout, .deleteWorkout:  path = "workout"
        case .user, .deleteUser:        path = "user"
        }
        if let id = self.id { path += "/\(id)" }
        return path
    }
    
    var id: Int? {
        switch self {
        case .news(let id, _): return id
        case .deleteNews(let id): return id
        case .trainer(let id, _): return id
        case .deleteTrainer(let id): return id
        case .client(let id, _): return id
        case .deleteClient(let id): return id
        case .workout(let id, _): return id
        case .deleteWorkout(let id): return id
        case .user(let id, _): return id
        case .deleteUser(let id): return id
        default: return nil
        }
    }
    
    var body: JSONDecodable? {
        switch self {
        case .news(_, let news): return news
        case .trainer(_, let trainer): return trainer
        case .client(_, let client): return client
        case .workout(_, let workout): return workout
        case .user(_, let user): return user
        default: return nil
        }
    }
        
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var method: HTTPMethod {
        if let _ = id, let _ = body { return .put }
        if let _ = body { return .post }
        switch self {
        case .deleteNews, .deleteTrainer, .deleteClient, .deleteWorkout, .deleteUser: return .delete
        default: return .get
        }
    }
}
