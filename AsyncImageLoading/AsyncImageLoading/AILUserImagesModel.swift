//
//  AILUserImageTypes.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

protocol AILUserImagesModelDelegate {
    func updateProgressBar(progress : Double)
    func updateDownloadedImage(imgData : Data)
}

class AILUserImagesModel: NSObject {
    var fullImage : String!
    var rawImage : String!
    var regularImage : String!
    var smallImage : String!
    var thumbnailImage : String!
    var downloadedImageData : Data?
    var downloadProgess : Progress?
    var alamofireUrlRequest : DataRequest!
    var delegate : AILUserImagesModelDelegate!

    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fullImage = json["full"].stringValue
        rawImage = json["raw"].stringValue
        regularImage = json["regular"].stringValue
        smallImage = json["small"].stringValue
        thumbnailImage = json["thumb"].stringValue
    }
    
    
    func downloadImageRequest(downloadUrl: String)
    {
        if(alamofireUrlRequest != nil){
            alamofireUrlRequest.cancel()
        }

                let url = NSURL(string: downloadUrl)
        var urlRequest = URLRequest(url: url! as URL)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
       alamofireUrlRequest =  Alamofire.request((urlRequest as URLRequestConvertible)).downloadProgress(closure : { (progress) in
            print(progress.fractionCompleted)
            self.downloadProgess = progress
            
            print("URL ==> \(self.fullImage) \t\t Progress ==>\(progress.completedUnitCount / progress.totalUnitCount)")
            
            let fraction = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
            self.delegate.updateProgressBar(progress: fraction)
            
            
        }).responseData  { (response) in
            print(response)
            print(response.data!)
            print(response.result.description)
            
            
            if response.result.isSuccess
            {
                self.downloadedImageData = response.data
                self.delegate.updateDownloadedImage(imgData: self.downloadedImageData!)
                self.alamofireUrlRequest = nil
                return
            }
            else {
                self.alamofireUrlRequest = nil
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                return
            }
            
        }
    }


}
