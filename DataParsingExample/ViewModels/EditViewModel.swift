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
    var editUrl : String?
    
    init(_ details :DetailDataModel , url : String) {
        self.details = details
        self.editUrl = url
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
    
    func update(_ newValue : String? , rowNumber : Int ) {
        
        switch rowNumber {
        case 0:
            details?.first_name = newValue
            break
        case 1 :
            details?.last_name = newValue
            break
        case 2 :
            details?.phone_number = newValue
            break
        default:
            details?.email = newValue
            break
        }
    }
    
    
    func done() {
        
        let validPass = self.isValidationsPass()
        
        if validPass == true {
            
            // make service call here
            let serviceManager = ServiceManager.init()
            serviceManager.putModifiedContacts(editUrl!, detailContact: self.details!, onCallBack: {
                
                (isSuccess, error) in
                if isSuccess == true {
                    
                    //asl view controller to show service call success
                    
                   self.viewController?.showAlertOnSuccess("Data Updated", message: "")
                }
                else {
                    // ask viewcontroller to show alert with below title and message
                    // title = Error
                    // message = error.localized description
                    self.viewController?.showAlert("Error", message: error!.localizedDescription)
                }
            })
        }
    }
    
    func isValidationsPass() -> Bool {

        if ((details?.first_name?.count ?? 0) < 2) || ((details?.last_name?.count ?? 0) < 2) {
            
            // ask view controller to show alert with below title and message
            // title =  Invalid Input
            // message = firstname and lastname should be more than 2 characters .
            self.viewController?.showAlert("Invalid Input", message: "firstname and lastname should be more than 2 characters")
            return false
            
        }
        else if ((details?.phone_number?.count ?? 0) < 10) {
            
            // ask view controller to show alert with below title and message
            // title =  Invalid Input
            // message = phone number should be more than 10 characters.
            self.viewController?.showAlert("Invalid Input", message: "phone number should be more than 10 characters.")
            return false
        }
        else if (self.isEmailAddressValid(details?.email ?? "") == false) {
            
            // ask view controller to show alert with below title and message
            // title =  Invalid Input
            // message = Email format is invalid.
            self.viewController?.showAlert("Invalid Input", message: "Email format is invalid")
            return false
        }
        else {
            
            return true
        }
    }
    
    func isEmailAddressValid(_ emailString:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: emailString, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, emailString.count)) != nil
        } catch {
            return false
        }
    }
}
