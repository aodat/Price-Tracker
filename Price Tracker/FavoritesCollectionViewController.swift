//
//  FavoritesCollectionViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/1/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import PKHUD
import RealmSwift

class FavoritesCollectionViewController: BaseCollectionViewController {
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        self.collectionView?.register(UINib(nibName:"ProductCell", bundle: nil), forCellWithReuseIdentifier: "ListProduct")
        getFavoritedProduct()
        PKHUD.sharedHUD.hide()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.products.removeAll()
        getFavoritedProduct()
        self.collectionView?.reloadData()
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

    
    
    func getFavoritedProduct(){
        let realm = try! Realm()
        let favoritedProduts = realm.objects(Favorited.self)
        for favoritedProdut in favoritedProduts {
            let product = Product()
            product.id          = favoritedProdut.id
            product.title       = favoritedProdut.title
            product.imageURL    = favoritedProdut.imageURL
            product.price       = favoritedProdut.price
            product.currency    = favoritedProdut.currency
            self.products.append(product)
        }
    }
    
}
