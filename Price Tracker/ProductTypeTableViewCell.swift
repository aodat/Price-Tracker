//
//  ProductTypeTableViewCell.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/7/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit

class ProductTypeTableViewCell: UITableViewCell{
    
    var productType = ProductType() {
        didSet {
            updateViews(productType: productType)
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red:242/255.0, green:246/255.0, blue:249/255.0, alpha:1.0)
        self.tintColor = UIColor(red:44.0/255.0, green:62.0/255.0, blue:80.0/255.0, alpha:1.0)
        self.accessoryType = selected ? .checkmark : .none
        self.selectedBackgroundView = selectedBackgroundView
        self.textLabel?.textColor = UIColor(red:44.0/255.0, green:62.0/255.0, blue:80.0/255.0, alpha:1.0)
        self.textLabel?.font = selected ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 16)
    }

    func updateViews(productType: ProductType) {
        self.textLabel?.text = productType.title
    }
    
}
