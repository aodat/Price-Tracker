//
//  ProductManager.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductManager {
    
    static var product:Product = Product()
    
    class func getProducts(completeion: ((Bool , String? , [Product]? ) -> Void)?)  {
        let url = Constants.URLs.getProduct
        let params = ["q":"iphone",
                      "country"     :Constants.RequestConfigurations.Country,
                      "language"    :Constants.RequestConfigurations.language,
                      "format"      :Constants.RequestConfigurations.format,
                      "app_id"      :Constants.RequestConfigurations.AppId,
                      "app_secret"  :Constants.RequestConfigurations.AppSecret
                    ]
            
        NetworkManager.get(url,params: params) { ( result) in
            
            switch result {
            case .success(let result):
                
                guard let productModel = result["products"] as? [[String : Any]] else {
                    completeion?(false , "No 'products' field.", nil)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    guard let products = Mapper<Product>().mapArray(JSONObject: productModel) else {
                        DispatchQueue.main.async {
                            completeion?(false, "Failed to map response into objects.", nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completeion?(true, nil , products)
                    }
                }
                
            case .fail(let reason):
                completeion?(false , reason.description, nil)
            }
        }
        
    }
}
