//
//  ProductTableViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/11/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import AlamofireImage

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
        self.productImageView.af_setImage(withURL: URL(string: productDetail.imageURL!)!)
        self.lastPriceLabel.text = "\(productDetail.price) \(productDetail.currency)"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateFormatted = formatter.string(from:productDetail.date )
        self.lastPriceDateLabel.text = dateFormatted
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
       
    }
    
    

}
    
    
    
    
    
