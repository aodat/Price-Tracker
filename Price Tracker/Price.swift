//
//  Price.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper

class Price: Root {
    
    var value = 0
    var currency = "$"
        
    override init() {
        super.init()
    }
    
    init(_ value: Int) {
        super.init()
        self.value = value
    }
    
    required init?(map: Map) {
        super.init(map: map)
        mapping(map: map)
    }
}
