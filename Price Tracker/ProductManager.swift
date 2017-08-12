//
//  ProductManager.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ProductManager {
    
    static var product:Product = Product()
    static var productType:ProductType = ProductType()
    
    class func getProducts(page: Int, completeion: ((Bool , String? , [Product]? ) -> Void)?)  {
        let url = Constants.URLs.getProducts
        var selectedProductTypesId = ""
        
        if let productypes = UserDefaults.standard.array(forKey: "selectedProductsTypesId") as? [String]{
            selectedProductTypesId = productypes.joined(separator: ",")
        }
        let params = ["product_types"   :selectedProductTypesId,
                      "page"            :"\(page)",
                      "country"         :Constants.RequestConfigurations.Country,
                      "language"        :Constants.RequestConfigurations.language,
                      "format"          :Constants.RequestConfigurations.format,
                      "app_id"          :Constants.RequestConfigurations.AppId,
                      "app_secret"      :Constants.RequestConfigurations.AppSecret
                    ]
            
        NetworkManager.get(url,params: params) { ( result) in
            
            switch result {
            case .success(let resultRoot):
                
                guard let result = resultRoot as? [String : Any] else {
                    completeion?(false , "No 'resultRoot' field.", nil)
                    return
                }
                
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
    
    class func getProductsTypes(page: Int, completeion: ((Bool , String? , [ProductType]? ) -> Void)?)  {
        let url = Constants.URLs.getProductType
        let params = ["page"        :"\(page)",
                      "language"    :Constants.RequestConfigurations.language,
                      "format"      :Constants.RequestConfigurations.format,
                      "app_id"      :Constants.RequestConfigurations.AppId,
                      "app_secret"  :Constants.RequestConfigurations.AppSecret
        ]
        
        NetworkManager.get(url,params: params) { ( result) in
            
            switch result {
            case .success(let resultRoot):
                
                guard let result = resultRoot as? [Any] else {
                    completeion?(false , "No 'resultRoot' field.", nil)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    guard let products = Mapper<ProductType>().mapArray(JSONObject: result) else {
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


    class func getProductById(productId: Int, completeion: ((Bool , String? , Product? ) -> Void)?)  {
        let url = Constants.URLs.getProductId(id: productId)
        
        let params = [
            "country"         :Constants.RequestConfigurations.Country,
            "language"        :Constants.RequestConfigurations.language,
            "format"          :Constants.RequestConfigurations.format,
            "app_id"          :Constants.RequestConfigurations.AppId,
            "app_secret"      :Constants.RequestConfigurations.AppSecret
        ]
        
        NetworkManager.get(url,params: params) { ( result) in
            
            switch result {
            case .success(let resultRoot):
                
                guard let productModel = resultRoot as? [String : Any] else {
                    completeion?(false , "No 'resultRoot' field.", nil)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    guard let product = Mapper<Product>().map(JSON: productModel) else {
                        DispatchQueue.main.async {
                            completeion?(false, "Failed to map response into objects.", nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completeion?(true, nil , product)
                    }
                }
                
            case .fail(let reason):
                completeion?(false , reason.description, nil)
            }
        }
        
    }
    
    class func getLastPriceForProduct(productId: String) -> Int{
        let realm = try! Realm()
        if let lastPrice = realm.objects(Price.self).filter("id = '\(productId)'").last?.price {
            return lastPrice
        }
        return 0
    }
    
    class func addPriceForProduct(productId: String, price: Int){
        let realm = try! Realm()
        try! realm.write {
            realm.create(Price.self, value: ["id": productId, "price": price ], update: false)
        }
    }
    
    class func addProductToFavorite(product: Product){
        
        let Favoritedproduct = Favorited()
        Favoritedproduct.id = product.id
        Favoritedproduct.categoryId = product.categoryId
        Favoritedproduct.title = product.title
        Favoritedproduct.imageURL = product.imageURL
        Favoritedproduct.currency = product.currency
        Favoritedproduct.price = product.price
    
        let realm = try! Realm()
        try! realm.write {
            realm.add(Favoritedproduct)
        }
        product.updatePrice()
    }
    
    class func removeProductFromFavorite(product: Product){
        let realm = try! Realm()
        try! realm.write {
            let objectsToDelete = realm.objects(Favorited.self).filter("id = '\(product.id)'").first
            realm.delete(objectsToDelete!)
        }
    }


    
}
