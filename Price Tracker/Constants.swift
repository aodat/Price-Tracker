//
//  Constants.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit

struct Constants {
    
    static let baseUrl = "https://api.souq.com/v1"
    
    struct storyboard {
        static var registration:UIStoryboard{
            get{ return  UIStoryboard(name: "Main", bundle: nil)}
        }
    }
    
    struct URLs {
        
        static var getProducts:String{
            get{ return  Constants.baseUrl + "/products?"}
        }
        
        static var getProductType:String{
            get{ return  Constants.baseUrl + "/products/types?"}
        }
        
        static func getProductId(id: Int) -> String{
             return  Constants.baseUrl + "/products/\(id)?"
        }


    }
    
    struct RequestConfigurations {
        
        static let AppId            = "62474504"
        static let AppSecret        = "akI9Cx8n5JrvC2X8rLGT"
        static let Country          = "ae"
        static let language         = "en"
        static let format           = "json"

    }
    
    struct OAuthSettings {
        
        static let AppId          = "62474504"
        static let AppSecret      = "akI9Cx8n5JrvC2X8rLGT"
        static let AuthorizeUri   = "https://api.souq.com/oauth/authorize"
        static let AccessTokenUri = "https://api.souq.com/oauth/access_token"
        static let RedirectUri    = "souq-price-tracker://oauth-callback"
        static let scope          = "OAuth2.0,discovery,customer_profile"
    }

    
    
}
