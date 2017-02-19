//
//  PrettyPrintable.swift
//  Traccar
//
//  Created by Alexey Papin on 09.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

protocol PrettyPrintable: class {
    var fields: (json: JSON, count: Int) { get }
    func prettyPrint(with level: Int) -> String
}

protocol JSONCodeable {
    var json: JSON { get }
}

extension PrettyPrintable {
    var fields: (json: JSON, count: Int) {
        var json = JSON()
        var count = 0
        for property in Mirror(reflecting: self).children {
            if let label = property.label {
                json[label] = property.value as AnyObject?
                count += 1
            }
        }
        return (json: json, count: count)
    }
    
    func prettyPrint(with level: Int) -> String {
        let tab = String(repeating: "\t", count: level)
        var pretty = "\(tab)\(type(of: self))<\(CFHash(self))>: {"
        var count = 0
        for (key, value) in self.fields.json {
            var stringRep = ""
            if (value is Array<Any> || value is Dictionary<String, Any>) {
                stringRep = "\(value.count!) items"
            } else {
                stringRep = String(describing: value)
            }
            pretty += "\n\t\(tab)\(key): \(stringRep)"
            count += 1
            if (count < self.fields.count) {
                pretty += ","
            }
        }
        pretty += "\n\(tab)}"
        return pretty
    }
}

extension Array where Element: PrettyPrintable {
    func prettyPrint(with level: Int) -> String {
        let tab = String(repeating: "\t", count: level)
        var pretty = "\(tab)\(type(of: self))<\(self.count) items>: {"
        for i in 0..<self.count {
            let item = self[i]
            pretty += "\n\t\(tab)\(i+1). \(item.prettyPrint(with: level + 1))"
        }
        pretty += "\n\(tab)}"
        return pretty
    }
}

