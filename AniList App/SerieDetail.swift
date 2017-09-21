//
//  SerieDetail.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/21/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import ObjectMapper

class SerieDetail: Mappable {
    
    var id: Int?
    var description: String?
    var characters: [Character]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        characters <- map["characters"]
    }
}
