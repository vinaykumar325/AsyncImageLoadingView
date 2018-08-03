//
//  AILUserProfileImageTypes.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUserProfileImageModel : NSObject {

    var largeImage : String!
    var mediumImage : String!
    var smallImage : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        largeImage = json["large"].stringValue
        mediumImage = json["medium"].stringValue
        smallImage = json["small"].stringValue
    }

}
