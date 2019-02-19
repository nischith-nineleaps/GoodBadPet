//
//  DeckViewController.swift
//  GBP
//
//  Created by Nineleaps on 12/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import ObjectMapper
import AlamofireObjectMapper
//import Poi


class DeckViewController : UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showLikedPets(_ sender: Any) {
        
        performSegue(withIdentifier: "SegueToLikedPets", sender: self)
        //show liked pets here after retreiving from the API using token as Authorisation header OR JUST CALL A FUNCTION TO CALL THE NEXT VIEW CONTROLLER
    }
    
    
    
}




