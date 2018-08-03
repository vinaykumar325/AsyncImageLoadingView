//
//  AILUserLinks.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUserLinks: NSObject {
    var photos : String!
    var selfPhotos : String!
    var download : String!
    var html : String!
    var likes : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        photos = json["photos"].stringValue
        selfPhotos = json["self"].stringValue
        download = json["download"].stringValue
        html = json["html"].stringValue
        likes = json["likes"].stringValue
    }

}
