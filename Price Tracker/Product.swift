//
//  Product.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper

class Price {
    
    var value = 0
    var currency = "$"
    
    init() {
    }
    
    init(_ value: Int) {
        self.value = value
    }
}

class Product: Mappable {
    
    var id = ""
    var categoryId = ""
    var title = ""
    var price = Price()
    var prices = [Price]()
    var imageURL: String?
    var favorited = false
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        categoryId  <- map["product_type_id"]
        title       <- map["label"]
        price       <- map["offer_price"]
        imageURL    <- map["images.L.0"]
    }
}
