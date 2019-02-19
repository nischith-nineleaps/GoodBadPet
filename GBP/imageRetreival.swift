//
//  imageRetreival.swift
//  GBP
//
//  Created by Nineleaps on 12/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageFullResponse : Mappable {
    var response: image_response?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        response <- map["response"]
    }
}
class image_response : Mappable {
    var imageData: actualImageData?
    var imageStatus: actualStatus?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        imageData <- map["data"]
    }
}
class actualStatus: Mappable {
    var code: String?
    var message: String?
    required init?(map: Map){
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}

class actualImageData: Mappable {
    var pets: [actualPetImageData]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        pets <- map["pets"]
    }
}
class actualPetImageData: Mappable {
    var id: String?
    var image: String?
    var name: String?
    var liked: Bool?
    var description: String?
    var __v: String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        id <- map["_id"]
        image <- map["image"]
        name <- map["name"]
        liked <- map["liked"]
        description <- map["description"]
        __v <- map["__v"]
    }
}

//import UIKit
//import Kingfisher
//
//class LikedCards: UIView {
//    
//    @IBOutlet weak var mealImage: UIImageView!
//    @IBOutlet weak var mealTitle: UILabel!
//    @IBOutlet weak var mealDesc: UILabel!
//    
//    override init(frame: CGRect){
//        super.init(frame: frame)
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//    func prepareUI(text: String, img: String, desc: String) {
//        mealTitle.text = text
//        let url = URL(string: img)
//        mealImage.kf.setImage(with: url)
//        mealDesc.text = desc
//    }
//}
