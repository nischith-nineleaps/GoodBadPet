//
//  SwipeViewController.swift
//  GBP
//
//  Created by Nineleaps on 12/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import Poi
import UIKit
import Alamofire
import SwiftKeychainWrapper
import ObjectMapper
import AlamofireObjectMapper
import Kingfisher


class SwipeViewController : UIViewController, PoiViewDataSource, PoiViewDelegate {
    var imgArray = [actualPetImageData]()
    let alamofire = AlamofireWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoRetreived()
    }
    
    
    @IBOutlet weak var poiView: PoiView!
    
    var sampleCards = [Card]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogOutActions(_ sender: Any) {
        alamofire.callAlamofireTokenResponse(nameOfOperation: "logout", parameters: nil, headers: nil) { (response) -> (Void) in
            if response.response?.statusCode == 200
            {
                let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "userToken")
                if removeSuccessful == true {
                    self.performSegue(withIdentifier: "SegueToMainPage", sender: self)
                }
            }
        }
    }
    
    func infoRetreived (){
        
        let headers : HTTPHeaders? = ["Authorization": KeychainWrapper.standard.string(forKey:"userToken")!]
        alamofire.callAlamofireImageResponse(nameOfOperation: "retrieveAllPets", url: nil, parameters: nil, headers: headers) { (response) -> (Void) in
            
            if response.response?.statusCode == 200
            {
                
                let imageStorage = response.result.value
                self.imgArray = (imageStorage?.response?.imageData?.pets!)!
                self.createViews()
                self.poiView.dataSource = self
                self.poiView.delegate = self
                
            }
        }
    }
    
    private func createViews() {
        for i in (0..<self.imgArray.count) {
            let card = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! Card
            //   let imageimage = imageimage.(with: imgArray[i].image! )
            card.prepareUI(text: imgArray[i].name!, img: imgArray[i].image! ,desc: imgArray[i].description!)
            sampleCards.append(card)
        }
    }
    
    
    
    
    // MARK: PoiViewDataSource
    func numberOfCards(_ poi: PoiView) -> Int {
        if self.imgArray.count != nil && self.imgArray.count > 0
        {
            return self.imgArray.count
        }
        else{return 0}
    }
    
    func poi(_ poi: PoiView, viewForCardAt index: Int) -> UIView {
        return sampleCards[index]
    }
    
    func poi(_ poi: PoiView, viewForCardOverlayFor direction: SwipeDirection) -> UIImageView? {
        switch direction {
        case .right:
            let good = UIImageView(image: #imageLiteral(resourceName: "good"))
            good.tintColor = UIColor.green
            return good
        case .left:
            let bad = UIImageView(image: #imageLiteral(resourceName: "bad"))
            bad.tintColor = UIColor.red
            return bad
        }
    }
    
    // MARK: PoiViewDelegate
    func poi(_ poi: PoiView, didSwipeCardAt: Int, in direction: SwipeDirection) {
        let headers : HTTPHeaders? = ["Authorization": KeychainWrapper.standard.string(forKey: "userToken")!]
        let urlString = URL( string: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes/"+imgArray[didSwipeCardAt-1].id!)
        switch direction {
            
        case .left:
            let parameters = ["liked": false]
            alamofire.callAlamofireImageResponse(nameOfOperation: "updateLikedPets", url: urlString, parameters: parameters, headers: headers) { (response) -> (Void) in
                  //  print(response.response!)
                    print("left")}
        case .right:
            let parameters = ["liked": true]
            alamofire.callAlamofireImageResponse(nameOfOperation: "updateLikedPets", url: urlString ,parameters: parameters, headers: headers) { (response) -> (Void) in
                    print("right")
            }
        }
    }
    
    func poi(_ poi: PoiView, runOutOfCardAt: Int, in direction: SwipeDirection) {
        print("last")
    }
    
    // MARK: IBAction
    @IBAction func OKAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .right)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .left)
    }
    
    @IBAction func undo(_ sender: UIButton) {
        poiView.undo()
    }
    
}
