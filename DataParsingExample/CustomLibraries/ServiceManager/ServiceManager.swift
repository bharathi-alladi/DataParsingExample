//
//  ServiceManager.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 23/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ServiceManager {
    
    func getContactList (onSuccess returnBlock:@escaping (([CoreDataModel]?, Error?) -> Void))
    {
        
        
        let url = URL.init(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
        let urlRequest = URLRequest.init(url: url!)
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
            
            if data != nil {
                let decoder = JSONDecoder.init()
                do {
                    
                    let fetchedData =  try decoder.decode([CoreDataModel].self, from: data!)
                    returnBlock(fetchedData, nil)
                } catch {
                    returnBlock(nil, error)
                }
            }
            else {
                returnBlock(nil, error)
            }
        })
        dataTask.resume()
    }
    
    func getDetails (_ url:String, onSuccess returnBlock:@escaping ((DetailDataModel?, Error?) -> Void))
    {
        
        let urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask (with: urlRequest, completionHandler: { (data, urlResponse, error) in
            
            if data != nil {
                let decoder = JSONDecoder.init()
                do {
                    let detailData =  try decoder.decode(DetailDataModel.self, from: data!)
                    returnBlock(detailData,nil)
                } catch {
                    returnBlock(nil, error)
                }
            }
            else {
                returnBlock(nil, error)
            }
        })
        dataTask.resume()
    }
    
    func putModifiedContacts(_ url: String, detailContact: DetailDataModel, onCallBack returnBlock:@escaping ((Bool?, Error?) -> Void) ) {
        
        var urlRequest = URLRequest.init(url: URL.init(string: url)!)
        urlRequest.httpMethod = "PUT"
        let encoder = JSONEncoder.init()
        do {
            urlRequest.httpBody = try encoder.encode(detailContact)
        } catch {
            returnBlock(nil, error)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (responseData, response, error) in
            
            if responseData != nil {
                let decoder = JSONDecoder.init()
                do {
                    let detailData =  try decoder.decode(DetailDataModel.self, from: responseData!)
                    returnBlock(true, nil)
                } catch {
                    returnBlock(nil, error)
                }
            }
            else {
                returnBlock(nil, error)
            }
        }
        dataTask.resume()
    }
}
