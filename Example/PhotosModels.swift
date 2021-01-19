//
//  PhotosModels.swift
//  Example
//
//  Created by Ngavt on 1/18/21.
//

import Foundation
import ObjectMapper

final class PhotosBO: Mappable {
    var photos: [PhotoBO]?
    func mapping(map: Map) {
        photos <- map["1"]
    }
    
    init?(map: Map) {}
}

final class PhotoBO: Mappable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        albumId <- map["albumId"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
    
    init?(map: Map) {}
}
