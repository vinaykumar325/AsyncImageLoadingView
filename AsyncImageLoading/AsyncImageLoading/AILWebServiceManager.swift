//
//  AILWebServiceManager.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 30/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AILWebServiceManager: NSObject,URLSessionDelegate {
    var dataTask: URLSessionDataTask?
    
    var alamofireUrlRequest : URLRequest!
    // Can't init is singleton
    private override init() {
    }
    
    //MARK: Shared Instance
    
    static let sharedWebServiceManager: AILWebServiceManager = AILWebServiceManager()
    
    
    func readAPIHeaders() -> Dictionary<String,String>
    {
        var headersDict : Dictionary<String,String> = Dictionary()
        headersDict["Content-Type"] = "application/json;charset=utf-8"
        headersDict["Accept"] = "application/json"
        return headersDict
    }
    
    
    func getRequest(requestParam: Dictionary<String , Any>,
                    endPoint: String?,
                    successCallBack: @escaping (_ responseData: JSON) -> Void,
                    failureCallBack: @escaping (_ error: Error) -> Void)
    {
        
        var completeURL : String!
        completeURL = endPoint
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .get, parameters: requestParam, encoding: URLEncoding.queryString, headers: nil);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack(response.error!)
                return
            }
            let dataDictionary = JSON(response.result.value!)
            print(response)
            successCallBack(dataDictionary)
            return
        }
        
    }
}
