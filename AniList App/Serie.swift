//
//  Serie.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/20/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import ObjectMapper

class Serie: Mappable {
    
    var id: Int?
    var title: String?
    var thumbImageUrl: String?
    var imageUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title_english"]
        thumbImageUrl <- map["image_url_med"]
        imageUrl <- map["image_url_lge"]
    }
}
