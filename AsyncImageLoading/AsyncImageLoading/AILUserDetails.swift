//
//  AILUserDetails.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUserDetails: NSObject {

    var id : String!
    var links : AILUserLinks!
    var name : String!
    var profileImage : AILUserProfileImageModel!
    var username : String!

    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].stringValue
        let linksJson = json["links"]
        if !linksJson.isEmpty{
            links = AILUserLinks(fromJson: linksJson)
        }
        name = json["name"].stringValue
        let profileImageJson = json["profile_image"]
        if !profileImageJson.isEmpty{
            profileImage = AILUserProfileImageModel(fromJson: profileImageJson)
        }
        username = json["username"].stringValue
    }
}
