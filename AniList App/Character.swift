//
//  Character.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/21/17.
//  Copyright © 2017 Making your app. All rights reserved.
//
import ObjectMapper

class Character: Mappable {
    
    var id: Int?
    var nameFirst: String?
    var nameLast: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        nameFirst <- map["name_first"]
        nameLast <- map["name_last"]
    }
}
