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

protocol JSONDecodable: class {
    var shouldSkipFields: [String]? { get }
    init?(with json: JSON)
    func json(shouldSkip fields: [String]?) -> JSON
    var json: JSON { get }
}

typealias Parse<J, T: JSONDecodable> = ((J) -> T?) where T: JSONDecodable

extension JSONDecodable {
    var shouldSkipFields: [String]? {
        return nil
    }
    
    private func include(property: Mirror.Child, shouldSkip fields: [String]?) -> Bool {
        if let shouldSkipFields = fields {
            for field in shouldSkipFields {
                if (property.label == field) {
                    return false
                }
            }
        }
        if let shouldSkipFields = self.shouldSkipFields {
            for field in shouldSkipFields {
                if (property.label == field) {
                    return false
                }
            }
        }
        return true
    }
    
    func json(shouldSkip fields: [String]?) -> JSON {
        var json: JSON = [:]
        for property in Mirror(reflecting: self).children {
            if let label = property.label {
                if include(property: property, shouldSkip: fields) {
                    if let value = property.value as? JSONDecodable {
                        if include(property: property, shouldSkip: fields) {
                            json[label] = value.json(shouldSkip: fields) as AnyObject?
                        } else {
                            json[label] = property.value as AnyObject?
                        }
                    } else {
                        json[label] = property.value as AnyObject?
                    }
                }
            }
        }
        return json
    }
    
    var json: JSON {
        return self.json(shouldSkip: self.shouldSkipFields)
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
