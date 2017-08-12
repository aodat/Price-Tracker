//
//  PricesTableViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/12/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import RealmSwift

class PricesTableViewController: BaseTableViewController {
    
    var productId = ""
    var prices = [Price]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            getPrices(productId: self.productId)
    }

    func getPrices(productId: String) {
        let realm = try! Realm()
        let prices = realm.objects(Price.self).filter("id = '\(self.productId)'")
        for price in prices {
            self.prices.append(price)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prices.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Price", for: indexPath) as! PriceTableViewCell
        
        cell.price = self.prices[indexPath.row]
        
        return cell
    }
}
