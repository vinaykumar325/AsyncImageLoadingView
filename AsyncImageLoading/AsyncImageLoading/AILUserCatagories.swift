//
//  AILUserCatagories.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUserCatagories: NSObject {
    var id : Int!
    var links : AILUserLinks!
    var photoCount : Int!
    var title : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        let linksJson = json["links"]
        if !linksJson.isEmpty{
            links = AILUserLinks(fromJson: linksJson)
        }
        photoCount = json["photo_count"].intValue
        title = json["title"].stringValue
    }
}
