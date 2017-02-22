//
//  APIClient.swift
//  Traccar
//
//  Created by Alexey Papin on 08.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {

    static func failureHandler<T>(completion: @escaping (T?) -> Void) -> (DataResponse<Any>) -> Void {
        return { (response: DataResponse<Any>) in
            if let value = response.result.value, let serverError = ServerError(with: value as! JSON) {
                print("\(serverError.json)")
            } else {
                guard
                let httpResponse = response.response,
                let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
                let error = response.result.error
                    else {
                        print("Unknown error while fetching")
                        return
                }
                print("Error while fetching: \(error) \(APIError.httpResponseStatusCodeError(statusCode).localizedDescription)")
            }
            completion(nil)
        }
    }
    
    func get<T: JSONDecodable>(endpoint: Endpoint, completion: @escaping (T?) -> Void) {
        endpoint.request.responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                APIClient.failureHandler(completion: completion)(response)
                return
            }
            
            guard
                let json = response.result.value as? JSON,
                let value = T(with: json)
                else {
                    APIClient.failureHandler(completion: completion)(response)
                    return
            }
            completion(value)
            return
        }
    }
    
    func getArray<T: JSONDecodable>(endpoint: Endpoint, completion: @escaping ([T]?) -> Void) {
        endpoint.request.responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                APIClient.failureHandler(completion: completion)(response)
                return
            }
            
            guard
                let jsonArray = response.result.value as? JSONArray,
                let values = [T](with: jsonArray)
                else {
                    APIClient.failureHandler(completion: completion)(response)
                    return
            }
            completion(values)
            return
        }
    }

    func delete(endpoint: Endpoint, completion: @escaping (DataResponse<Any>) -> Void) {
        endpoint.request.responseJSON { (response) -> Void in
            completion(response)
        }
    }
}
