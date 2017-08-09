//
//  Authentication Manager.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/8/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//
//
import UIKit
import p2_OAuth2

class AuthenticationManager {
    
    static let sharedInstance = AuthenticationManager()
    
    private var oauth2: OAuth2CodeGrant
    
    private let settings: OAuth2JSON = [
        "client_id": Constants.OAuthSettings.AppId,
        "client_secret": Constants.OAuthSettings.AppSecret,
        "authorize_uri": Constants.OAuthSettings.AuthorizeUri,
        "token_uri": Constants.OAuthSettings.AccessTokenUri,
        "redirect_uris": [Constants.OAuthSettings.RedirectUri],
        "scope": Constants.OAuthSettings.scope,
        "keychain": true,
        ]


    private init() {
        oauth2 = OAuth2CodeGrant(settings: settings)
        oauth2.authConfig.authorizeEmbedded = false
        oauth2.clientConfig.secretInBody = true
    }
    
    class func authorize(completion: ()->()) {
        sharedInstance.oauth2.authorize() { authParameters, error in
            if let params = authParameters {
                print("Authorized! Access token is in `oauth2.accessToken`")
                print("Authorized! Additional parameters: \(params)")
            }
            else {
                print("Authorization was canceled or went wrong: \(error)")
            }
        }
        completion()
    }
    
    class func authorizeEmbeddedFrom(context: AnyObject) {
        sharedInstance.oauth2.authorizeEmbedded(from: context) { (authparams, error) in
            print(authparams?.count)
        }
    }
    
    class func handleRedirectURL(redirectURL: URL) {
        sharedInstance.oauth2.handleRedirectURL(redirectURL)
    }
    
}
