//
//  tokenSaver.swift
//  GBP
//
//  Created by Nineleaps on 11/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenResponse : Mappable {
    var response: response?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        response <- map["response"]
    }
}
class response : Mappable {
    var responseData: data?
    var responseStatus: status?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        responseData <- map["data"]
    }
}
class status: Mappable {
    var code: String?
    var message: String?
    required init?(map: Map){
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}

class data: Mappable {
    var token: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        token <- map["token"]
    }
}

