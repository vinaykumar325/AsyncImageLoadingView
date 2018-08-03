//
//  AsyncImageLoadingView.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 01/08/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AsyncImageLoadingView: UIView,AILUserImagesModelDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak  var progressBar : UIProgressView!
    var userImagesModel : AILUserImagesModel!
    var alamofireUrlRequest : DataRequest!
    var downloadingUrl : String!
    let nibName = "AsyncImageLoadingView"
    var view : UIView!
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        self.userImagesModel = AILUserImagesModel.init(fromJson:[:] )
    }
    
    func downloadImageFromURL(downloadUrl: String)
    {
        self.userImageView.image = nil
        self.progressBar.progress = 0
        
        if(alamofireUrlRequest != nil){
            alamofireUrlRequest.cancel()
        }
        downloadingUrl = downloadUrl
        let url = NSURL(string: downloadUrl)
        var urlRequest = URLRequest(url: url! as URL)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        alamofireUrlRequest =  Alamofire.request((urlRequest as URLRequestConvertible)).downloadProgress(closure : { (progress) in
            print(progress.fractionCompleted)
            self.updateProgressBar(progress: progress.fractionCompleted)
        }).responseData  { (response) in
            print(response)
            print(response.data!)
            print(response.result.description)
            if response.result.isSuccess
            {
                self.userImageView.image = UIImage(data: response.data!)
                return
            }
            else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                return
            }
            
        }
        
    }
    
    
    func setThumbNailImage ()
    {
        self.userImageView.image = UIImage(data: userImagesModel.downloadedImageData!)
    }
    
    func setProgressBar()
    {
        self.progressBar.setProgress(Float((userImagesModel.downloadProgess?.fractionCompleted)!), animated: true)
        
    }
    
    func updateProgressBar(progress : Double)
    {
        self.progressBar.isHidden = false
        self.progressBar.setProgress(Float(progress), animated: true)
    }
    
    func updateDownloadedImage(imgData : Data)
    {
        self.userImageView.image = UIImage(data: imgData)
        self.progressBar.isHidden = true
    }
    
    @IBAction func cancelAction()
    {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({
                if ($0.originalRequest?.url?.absoluteString == self.downloadingUrl)
                {
                    $0.cancel()
                }})
        }
        
    }
    
}
