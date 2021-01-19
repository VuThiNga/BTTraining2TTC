//
//  BaseModel.swift
//  Example
//
//  Created by Ngavt on 1/18/21.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    var error_code: Int?
    var message: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        error_code <- map["error_code"]
        message <- map["message"]
    }
}
