//
//  Price.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import RealmSwift

class Price: Object {
    
    dynamic var id       = ""
    dynamic var price    = 0
    dynamic var currency = ""
    dynamic var date     = ""
    
}

class Favorited: Object {
    
    dynamic var id          = ""
    dynamic var categoryId  = ""
    dynamic var title       = ""
    dynamic var imageURL    = ""
    dynamic var currency    = ""
    dynamic var price       = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
