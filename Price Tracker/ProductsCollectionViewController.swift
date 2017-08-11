//
//  ProductsCollectionViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/1/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import PKHUD

class ProductsCollectionViewController: BaseCollectionViewController {
    
    var products = [Product]()
    var page     = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        self.collectionView?.register(UINib(nibName:"ProductCell", bundle: nil), forCellWithReuseIdentifier: "ListProduct")
        PKHUD.sharedHUD.hide() { success in
            ProductManager.getProducts(page: self.page) { (success, errorMsg , products) in
                if let products = products {
                    self.products = products
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let padding:CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListProduct", for: indexPath) as! ProductCollectionViewCell
        
        cell.product = self.products[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ProductDetailViewController = storyboard.instantiateViewController(withIdentifier: "Product") as! ProductDetailTableViewController
        ProductDetailViewController.productDetail = self.products[indexPath.row]
        self.navigationController?.pushViewController(ProductDetailViewController, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.products.count - 1 {
            self.page += 1
            loadMoreProductType()
        }
    }
    
    func loadMoreProductType(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        ProductManager.getProducts(page: self.page) { (success, errorMsg , products) in
            if let products = products {
                for index in 0...9 {
                    self.products.append(products[index])
                }
                PKHUD.sharedHUD.hide() { success in
                    self.collectionView?.reloadData()
                }
            }
        }
    }

}
