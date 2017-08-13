//
//  ProductTypesViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/7/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import PKHUD

class ProductTypesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var productTypes = [ProductType]() 
    var page:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        HUD.flash(.progress)
            ProductManager.getProductsTypes(page: self.page) { (success, errorMsg , productsType) in
                if let productsType = productsType {
                    self.productTypes = productsType
                    self.tableView?.reloadData()
                    HUD.hide()
                }
            }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductType", for: indexPath) as! ProductTypeTableViewCell
        cell.productType = self.productTypes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.productTypes.count - 1 {
            self.page += 1
            loadMoreProductType()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nextButton.isEnabled = true
        self.productTypes[indexPath.row].isSelected = !self.productTypes[indexPath.row].isSelected
    }
    
    func loadMoreProductType(){
        HUD.flash(.progress)
            ProductManager.getProductsTypes(page: self.page) { (success, errorMsg , productsType) in
                if let productsType = productsType {
                    if productsType.count > 0 {
                        for index in 0...9 {
                            self.productTypes.append(productsType[index])
                        }
                    }
                        self.tableView?.reloadData()
                        HUD.hide()
                }
            }
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        var selectedProductIds = [String]()
        for productType in self.productTypes{
            if productType.isSelected == true {
                selectedProductIds.append(productType.id )
            }
        }
        UserDefaults.standard.set(selectedProductIds, forKey: "selectedProductsTypesId")
        UserDefaults.standard.synchronize()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home")
        present(homeTabViewController, animated: true, completion: nil)
        
    }
    
    
}
