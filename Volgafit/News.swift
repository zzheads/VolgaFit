//
//  News.swift
//  volgofit
//
//  Created by Alexey Papin on 14.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation

//private Long id;
//private Date date;
//private String text;
//private String author;
//private Set<String> hashTags = new HashSet<>(0);
//private String image;

class News: JSONDecodable, PrettyPrintable {
    let id: Int
    let date: String
    let text: String
    let author: String?
    let hashTags: [String]?
    let image: String?
    
    init(id: Int, date: String, text: String, author: String?, hashTags: [String]?, image: String?) {
        self.id = id
        self.date = date
        self.text = text
        self.author = author
        self.hashTags = hashTags
        self.image = image
    }
    
    required convenience init?(with json: JSON) {
        guard
            let id = json["id"] as? Int,
            let date = json["date"] as? String,
            let text = json["text"] as? String
            else {
                return nil
        }
        let author = json["author"] as? String
        let hashTags = json["hashTags"] as? [String]
        let image = json["image"] as? String
        self.init(id: id, date: date, text: text, author: author, hashTags: hashTags, image: image)
    }
}
