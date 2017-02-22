//
//  JSON.swift
//  Traccar
//
//  Created by Alexey Papin on 08.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]
typealias JSONArray = [JSON]

typealias JSONTaskCompletion = (JSON?, HTTPURLResponse?, Error?) -> Void
typealias JSONArrayTaskCompletion = (JSONArray?, HTTPURLResponse?, Error?) -> Void
typealias TaskCompletion<J> = (J?, HTTPURLResponse?, Error?) -> Void

typealias JSONTask = URLSessionDataTask
typealias URLSessionDataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

protocol JSONDecodable {
    init?(with json: JSON)
    var json: JSON { get }
}

typealias Parse<J, T: JSONDecodable> = ((J) -> T?) where T: JSONDecodable

extension JSONDecodable {
    
    var json: JSON {
        var json: JSON = [:]
        for property in Mirror(reflecting: self).children {
            if let label = property.label {
                if let value = property.value as? JSONDecodable {
                    json[label] = value.json as AnyObject?
                } else {
                    json[label] = property.value as AnyObject?
                }
            }
        }
        return json
    }
    
    static var parse: Parse<JSON, Self> {
        return { (json: JSON) in
            return Self.init(with: json)
        }
    }
}

extension Array where Element: JSONDecodable {
    init?(with jsonArray: JSONArray) {
        self.init()
        for json in jsonArray {
            if let value = Element.init(with: json) {
                self.append(value)
            } else {
                return nil
            }
        }
    }
    
    static var parse: Parse<JSONArray, Array> {
        return { (jsonArray: JSONArray) in
            return Array.init(with: jsonArray)
        }
    }
}
