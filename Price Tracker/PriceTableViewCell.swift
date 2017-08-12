//
//  PriceTableViewCell.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/11/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var price = Price() {
        didSet {
            updateViews(price: price)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews(price price: Price) {
        self.priceLabel.text = "\(price.price) \(price.currency)"
        self.dateLabel.text = price.date
    }
}
