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
    case workout(id: Int?, client: Workout?)
    case deleteWorkout(id: Int)
    case user(id: Int?, user: User?)
    case deleteUser(id: Int)
    case login(user: User)
    case sendmail(username: String)
    
    //var baseUrl: URL { return URL(string: "https://volgofit.herokuapp.com/api/")!}
    var baseUrl: URL { return URL(string: "http://localhost:8080/api/")!}
    
    var path: String {
        var path = ""
        switch self {
        case .info:                     path = "info"
        case .model:                    path = "model"
        case .news, .deleteNews:        path = "news"
        case .workout, .deleteWorkout:  path = "workout"
        case .user, .deleteUser:        path = "user"
        case .login:                    path = "user/login"
        case .sendmail:                 path = "user/sendmail"
        }
        if let id = self.id { path += "/\(id)" }
        if let query = self.query { path += query }
        return path
    }
    
    var query: String? {
        switch self {
        case .sendmail(let username): return "?username=\(username)"
        default: return nil
        }
    }
    
    var id: Int? {
        switch self {
        case .news(let id, _): return id
        case .deleteNews(let id): return id
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
        case .workout(_, let workout): return workout
        case .user(_, let user): return user
        case .login(let user): return user
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
        case .deleteNews, .deleteWorkout, .deleteUser: return .delete
        default: return .get
        }
    }
}
