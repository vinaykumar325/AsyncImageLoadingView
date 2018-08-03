//
//  AILUserImageTableViewCell.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUserImageTableViewCell: UITableViewCell {
    
    var userImagesModel : AILUserImagesModel!
    var asyncImageLodingView: AsyncImageLoadingView!
    @IBOutlet weak var overlayView : UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        asyncImageLodingView.layer.shadowOpacity = 1
        asyncImageLodingView.layer.shadowOffset = CGSize.zero
        asyncImageLodingView.layer.shadowRadius = 5
        asyncImageLodingView.layer.shadowColor = UIColor.gray.cgColor
        asyncImageLodingView.layer.cornerRadius = 10.0
        asyncImageLodingView.frame = overlayView.bounds
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDataSource(userImageModel : AILUserImagesModel)
    {
        if self.asyncImageLodingView == nil
        {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "AsyncImageLoadingView", bundle: bundle)
            self.asyncImageLodingView = nib.instantiate(withOwner: self, options: nil)[0] as! AsyncImageLoadingView
            self.overlayView.addSubview(self.asyncImageLodingView)
        }
        
        userImagesModel = userImageModel
        
        self.userImagesModel.delegate = self.asyncImageLodingView
        self.asyncImageLodingView.userImageView.image = nil
        self.asyncImageLodingView.downloadingUrl = userImageModel.fullImage
        
        if userImageModel.downloadedImageData == nil{
            self.asyncImageLodingView.progressBar.progress = 0
            self.userImagesModel.downloadImageRequest(downloadUrl: userImageModel.fullImage)
        }
        else {
            self.asyncImageLodingView.updateProgressBar(progress: 1.0)
            self.asyncImageLodingView.updateDownloadedImage(imgData: userImageModel.downloadedImageData!)
        }
    }
}
