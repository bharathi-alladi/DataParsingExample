//
//  ListViewModel.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 23/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class ListViewModel {
    
    var fetchedData : [CoreDataModel] = []
    var viewController : ListViewController?
    
    // MARK: - initiliazer
    init() {
        
    }
    
    // MARK: - Service Call
    func fetchData() {
        let serviceManager = ServiceManager.init()
        serviceManager.getContactList(onSuccess: {
            (fetchedData, error) in
            
            if fetchedData != nil {
                self.fetchedData = fetchedData!
                self.viewController?.reloadTableView()
            }
            else {
                self.viewController?.displayAlert(with: error)
            }
        })
    }
    
    
    // MARK: - ViewController's helper functions
    func getRowCount() -> Int {
        return fetchedData.count
    }
    
    func getContact(index:Int) -> CoreDataModel {
        
        return fetchedData[index]
    }
    
    // MARK: - Route to other state
    func rowSelected(_ index:Int) {
        
        let contact = fetchedData[index]
        Router.sharedInstance.routeToDetailView(contact)
    }
}
