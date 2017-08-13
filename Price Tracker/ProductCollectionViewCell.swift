//
//  ProductCollectionViewCell.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift
import PKHUD

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
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        let realm = try! Realm()
        let query = realm.objects(Favorited.self).filter("id = '\(product.id)'").count
        
        if query < 1 {
            ProductManager.addProductToFavorite(product: product)
            HUD.flash(.label("Added To Favorite"), delay: 1.0) { _ in
                print("item added to fav")
            }
            self.favoriteButton.setImage(UIImage(named: "active_favorite"), for: .normal)
        } else {
            ProductManager.removeProductFromFavorite(product: product)
            HUD.flash(.label("Removed From Favorite"), delay: 1.0) { _ in
                print("item removed from fav")
            }
            self.favoriteButton.setImage(UIImage(named: "deactive_favorite"), for: .normal)            
        }
    }
    
}
