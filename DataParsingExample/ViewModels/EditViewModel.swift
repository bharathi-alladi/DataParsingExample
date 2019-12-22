//
//  EditViewModel.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 14/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class EditViewModel {

    var viewController : EditViewController?
    var details : DetailDataModel?
    
    init(_ details :DetailDataModel) {
        self.details = details
    }
    
    func getDataForCell(_ row: Int) -> [String] {
      
        var returnArray:[String] = []
        
        switch row {
        case 0:
            returnArray.append("First Name :")
            returnArray.append((details?.first_name)!)
            break
        case 1:
            returnArray.append("Last Name :")
            returnArray.append((details?.last_name)!)
            break
        case 2:
            returnArray.append("Phone Number :")
            returnArray.append((details?.phone_number) ?? "")
            break
        default:
            returnArray.append("Email :")
            returnArray.append((details?.email) ?? "")
            break
        }
        
        return returnArray
    }
    
}
