//
//  Product.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: Root {
    
    var id = ""
    var categoryId = ""
    var title = ""
    var price = 0
    var currency = ""
    var imageURL = ""
    var favorited = false
    var date = Date()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
        mapping(map: map)
    }
    
    override func mapping(map: Map) {
        id          <- map["id"]
        categoryId  <- map["product_type_id"]
        title       <- map["label"]
        price       <- map["offer_price"]
        currency    <- map["currency"]
        imageURL    <- map["images.L.0"]
    }
    
    func updatePrice(){
        if  ProductManager.getLastPriceForProduct(productId: self.id) != self.price {
            ProductManager.addPriceForProduct(productId: self.id, price: self.price, date: self.date, currency: self.currency)
        }
    }
}
