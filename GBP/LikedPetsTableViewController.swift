//
//  LikedPetsTableViewController.swift
//  GBP
//
//  Created by Nineleaps on 13/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Alamofire

class LikedPetsTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar : UISearchBar!
    
    @IBOutlet weak var LikedPetTableView: UITableView!
    
    var searchActive = false
    var imgArray = [actualPetImageData]()
    var currentArray = [actualPetImageData]() //update table
    let alamofire = AlamofireWrapper()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoRetreived()
        setUpSearchBar()

    }
    //DataSource function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "LikedPetsTableViewCell") as! LikedCards

        if searchActive{
            let data = currentArray[indexPath.row]
            cell.prepareUI(text: data.name!, img: data.image!, desc: data.description!)
            return cell
        }
        else {
        let data = imgArray[indexPath.row]
        cell.prepareUI(text: data.name!, img: data.image!, desc: data.description!)
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    //delegate function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return currentArray.count
        }
        else{
             return imgArray.count
        }
    }
    
    func infoRetreived(){
        alamofire.callAlamofireImageResponse(nameOfOperation: "retrieveLikedPets", url: nil, parameters: nil, headers: nil) { (response) -> (Void) in
                if response.response?.statusCode == 200
                {
                    
                    let imageStorage = response.result.value
                    self.imgArray = (imageStorage?.response?.imageData?.pets!)!
                    self.currentArray = self.imgArray
                    self.LikedPetTableView.delegate = self
                    self.LikedPetTableView.dataSource = self
                    
                    self.LikedPetTableView.tableFooterView = UIView(frame: CGRect.zero)
                }
        }
        
    }
    
    //SEARCH BAR FUNCTIONS
    
    func searchBar(_ searchBar: UISearchBar , textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchActive = false
            LikedPetTableView.reloadData()
            return }
        currentArray = imgArray.filter({ petImageData -> Bool in
            petImageData.name!.contains(searchText) || petImageData.description!.contains(searchText)
        })
        self.searchActive = true
        LikedPetTableView.reloadData()
    }
    
   private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    
}
