//
//  LikedCards.swift
//  GBP
//
//  Created by Nineleaps on 13/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Kingfisher

class LikedCards: UITableViewCell{
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealDesc: UILabel!
    
    
    func prepareUI(text: String, img: String, desc: String) {
        mealTitle.text = text
        let url = URL(string: img)
        mealImage.kf.setImage(with: url)
        mealDesc.text = desc
    }
}
