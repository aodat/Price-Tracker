//
//  NetworkManager.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/2/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NetworkManager: NSObject {
    
    enum FailReason {
        
        case noInternet
        case `protocol`(String)
        case unknown(String)
        
        var description: String {
            switch self {
            case .noInternet:
                return NSLocalizedString("NO_INTERNET_CONNECTION", comment: "")
            case .protocol(let details):
                return details
            case .unknown(let details):
                return details
            }
        }
    }
    
    enum Result {
        case success([String: Any])
        case fail(FailReason)
    }
    
    static func get(_ url: String, params: [String: Any] = [:], _ completion: ((Result) -> Void)?) {
        request(url, method: .get, parameters: params, headers: preparehttpHeaders())
            .responseJSON { (response: DataResponse<Any>) in
                processServerResponse(response, completion)
                print(response)
        }
    }
    
    static func post(_ url: String, params: [String: Any] = [:], tokenPresent: Bool = true, _ completion: ((Result) -> Void)?) {
        request(url, method: .post, parameters: params, headers: preparehttpHeaders())
            .responseJSON { (response: DataResponse<Any>) in
                processServerResponse(response, completion)
                print(response)
        }
    }
    
    static func processServerResponse(_ response: DataResponse<Any>, _ completion: ((Result) -> Void)?) {
        
        switch response.result {

        case .success:
            
            guard let root = response.result.value as? [String: Any] else {
                completion?(.fail(.protocol("Could not find JSON body response.")))
                return
            }
            
            guard let meta = root["meta"] as? [String: Any] else {
                completion?(.fail(.protocol("Could not find JSON body response.")))
                return
            }
            
            guard let data = root["data"] as? [String: Any] else {
                completion?(.fail(.protocol("Could not find JSON body response.")))
                return
            }
            
            guard let status = meta["status"] as? Int else{
                completion?(.fail(
                    .protocol("Could not find 'status' flag in the response.")))
                return
            }
            
            guard [200, 201, 204, 208, 202].contains(status) else {
                completion?(.fail(.protocol("Server returned: \(status)_.")))
                return
            }
            
            completion?(.success(data))
            
        case .failure:
            guard let error = response.result.error else {
                completion?(.fail(.unknown(response.result.description)))
                return
            }
            if NetworkManager.isNoInternetError(error) {
                completion?(.fail(.noInternet))
            } else {
                completion?(.fail(.unknown(error.localizedDescription)))
            }
        }
    }
    
    public static func isNoInternetError(_ error: Error) -> Bool {
        guard NSURLErrorDomain == error._domain else {
            return false
        }
        switch error._code {
        case NSURLErrorTimedOut:
            return true
        case NSURLErrorCannotFindHost:
            return true
        case NSURLErrorNetworkConnectionLost:
            return true
        case NSURLErrorNotConnectedToInternet:
            return true
        default:
            return false
        }
    }
    
    private static func preparehttpHeaders() -> [String: String] {
        
        let headers = ["":""]
        return headers
    }
    
}
