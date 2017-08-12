//
//  ProductCollectionViewCell.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import AlamofireImage

enum ProductCellSet {
    case All
    case Favorited
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var deleteFavoriteButton: UIButton!
    
    var product = Product() {
        didSet {
            updateViews(product: product)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews(product: Product) {
        self.productTitleLabel.text = product.title
        self.productImageView.af_setImage(withURL:URL(string: product.imageURL)!)
    }
    
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        print("favoriteButtonTapped:")
    }
    
    @IBAction func deleteFavoriteButtonTapped(sender: AnyObject) {
        print("deleteFavoriteButtonTapped:")
    }
}
