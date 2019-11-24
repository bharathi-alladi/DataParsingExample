//
//  ListViewModel.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 23/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ListViewModel {

    var completionHandler : ((Data?,URLResponse?,Error?) -> Void )?
    var fetchedData : [CoreDataModel] = []
    
    var viewController : ViewController?
    
    init() {
        self.completionHandler = {
            (data : Data?, urlresponse : URLResponse?, error : Error? ) -> Void in
            
            if data != nil {
                let decoder = JSONDecoder.init()
                do {
                    self.fetchedData =  try decoder.decode([CoreDataModel].self, from: data!)
                } catch {
                    print(error.localizedDescription)
                    
                }
                self.viewController?.reloadTableView()
            }
            else {
                self.viewController?.displayAlert(with: error)
            }
        }
    }
    
    func fetchData() {
        let serviceManager = ServiceManager.init()
        serviceManager.getContactList(onSuccess: self.completionHandler!)
    }
    
    func getRowCount() -> Int {
        return fetchedData.count
    }
    
    func getContact(index:Int) -> CoreDataModel {
        
        return fetchedData[index]
    }
}
