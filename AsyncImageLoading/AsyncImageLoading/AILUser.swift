//
//  AILUser.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 31/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AILUser: NSObject {

    
    var categories : [AILUserCatagories]!
    var color : String!
    var createdAt : String!
    var height : Int!
    var id : String!
    var likedByUser : Bool!
    var likes : Int!
    var imageUrl : AILUserImagesModel!
    var user : AILUserDetails!
    var width : Int!
    var links : AILUserLinks!


    
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categories = [AILUserCatagories]()
        let categoriesArray = json["categories"].arrayValue
        for categoriesJson in categoriesArray{
            let value = AILUserCatagories(fromJson: categoriesJson)
            categories.append(value)
        }
        color = json["color"].stringValue
        createdAt = json["created_at"].stringValue
        height = json["height"].intValue
        id = json["id"].stringValue
        likedByUser = json["liked_by_user"].boolValue
        likes = json["likes"].intValue
        let linksJson = json["links"]
        if !linksJson.isEmpty{
            links = AILUserLinks(fromJson: linksJson)
        }
        let urlsJson = json["urls"]
        if !urlsJson.isEmpty{
            imageUrl = AILUserImagesModel(fromJson: urlsJson)
        }
        let userJson = json["user"]
        if !userJson.isEmpty{
            user = AILUserDetails(fromJson: userJson)
        }
        width = json["width"].intValue
    }

}
