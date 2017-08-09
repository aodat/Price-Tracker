//
//  ProductType.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductType: Root {
    
    var id = ""
    var title = ""
    var url: String?
    var isSelected = false
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
        mapping(map: map)
    }

    override func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["label_plural"]
        url     <- map["link"]
    }
}
