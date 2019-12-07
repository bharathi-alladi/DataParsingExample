//
//  ServiceManager.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 23/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ServiceManager {

    func getContactList (onSuccess returnBlock:@escaping ((Data?, URLResponse?, Error?) -> Void))
    {
        
        
        let url = URL.init(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
        let urlRequest = URLRequest.init(url: url!)
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask (with: urlRequest, completionHandler: returnBlock)
        dataTask.resume()
    }
    
    func getDetails (_ url:String, onSuccess returnBlock:@escaping ((Data?, URLResponse?, Error?) -> Void)) {
        
        let urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask (with: urlRequest, completionHandler: returnBlock)
        dataTask.resume()
    }
}
