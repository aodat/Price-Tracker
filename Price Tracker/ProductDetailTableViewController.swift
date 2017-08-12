//
//  ProductTableViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/11/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift
import PKHUD

class ProductDetailTableViewController: BaseTableViewController {
    
    var productDetail = Product()
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var lastPriceLabel: UILabel!
    @IBOutlet weak var lastPriceDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTitleLabel.text = productDetail.title
        self.productImageView.af_setImage(withURL: URL(string: productDetail.imageURL)!)
        self.lastPriceLabel.text = "\(productDetail.price) \(productDetail.currency)"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateFormatted = formatter.string(from:productDetail.date )
        self.lastPriceDateLabel.text = dateFormatted
        self.navigationItem.title = productDetail.title
    }
    
    @IBAction func favoriteButtonTapped(_ sender: AnyObject) {
        let realm = try! Realm()
        let query = realm.objects(Favorited.self).filter("id = '\(self.productDetail.id)'").count
        
        if query < 1 {
            ProductManager.addProductToFavorite(product: self.productDetail)
            HUD.flash(.label("Added To Favorite"), delay: 1.0) { _ in
                print("item added to fav")
            }
            self.favoriteButton.setImage(UIImage(named: "active_favorite"), for: .normal)
        } else {
            ProductManager.removeProductFromFavorite(product: self.productDetail)
            HUD.flash(.label("Removed From Favorite"), delay: 1.0) { _ in
                print("item removed from fav")
            }
            self.favoriteButton.setImage(UIImage(named: "deactive_favorite"), for: .normal)


        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                showOldPrices()
            }
        }
    }
    
    func showOldPrices(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ProductPrices = mainStoryboard.instantiateViewController(withIdentifier: "ProductPrices") as! PricesTableViewController
        self.navigationController?.pushViewController(ProductPrices, animated: true)
        ProductPrices.productId = self.productDetail.id
    }
    

}
    
    
    
    
    
