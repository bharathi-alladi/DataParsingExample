//
//  DetailDataModel.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 7/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class DetailDataModel: Codable {

    var id : Int!
    var first_name : String!
    var last_name : String!
    var email : String?
    var phone_number : String?
    var profile_pic : String!
    var favorite : Bool!
    var created_at : String!
    var updated_at : String!

}
