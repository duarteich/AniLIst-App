//
//  Episode.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/21/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import ObjectMapper

class Episode: Mappable {
    
    var id: Int?
    var name: String?
    var description: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }
}
