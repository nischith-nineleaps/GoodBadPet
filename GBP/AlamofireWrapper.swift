//
//  AlamofireWrapper.swift
//  GBP
//
//  Created by Nineleaps on 15/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireWrapper : FileWrapper {
    //    var response = ImageFullResponse
    let loginURL = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/login"
    let logoutURL = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/logout"
    let getLikedPetsURL = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes"
    let updateLikedPetsURL = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes/"
    let getAllPetsURL = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets"
    
    func callAlamofireTokenResponse( nameOfOperation: String, parameters : [String: Any]?, headers: String?, completion: @escaping ((DataResponse<TokenResponse>)) -> (Void)) {
        switch (nameOfOperation){
            
        case "logout":
            Alamofire.request(logoutURL ,method:.post , parameters: nil , encoding: JSONEncoding.default ,headers: nil).responseObject {
                (response: DataResponse<TokenResponse>) in
                completion(response)
            }
            break
        case "login":
            Alamofire.request(loginURL ,method:.post , parameters: parameters , encoding: JSONEncoding.default ,headers: nil).responseObject {
                (response: DataResponse<TokenResponse>) in
                completion(response)
            }
            break
        default: return

        }
    }
    
    
    func callAlamofireImageResponse( nameOfOperation: String, url : URL? , parameters : [String: Any]?, headers: HTTPHeaders?, completion: @escaping ((DataResponse<ImageFullResponse>)) -> (Void)) {
        switch (nameOfOperation){
            
        case "retrieveAllPets":
            Alamofire.request(getAllPetsURL ,method:.get , parameters: nil , encoding: JSONEncoding.default ,headers: headers).responseObject {(response: DataResponse<ImageFullResponse>) in
                completion(response)
            }
            break
        case "retrieveLikedPets":
            Alamofire.request(getLikedPetsURL ,method:.get , parameters: nil , encoding: JSONEncoding.default ,headers: nil).responseObject { (response: DataResponse<ImageFullResponse>) in
                completion(response)
            }
            break
        case "updateLikedPets":
            Alamofire.request(url! ,method:.put , parameters: parameters ,  encoding: JSONEncoding.default ,headers: headers).responseObject { (response: DataResponse<ImageFullResponse>) in
                completion(response)
            }
            break
        default: return
        }
    }
    
    
    
}
