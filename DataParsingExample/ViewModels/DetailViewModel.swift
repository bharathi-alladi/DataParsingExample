//
//  DetailViewModel.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 8/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    var data : CoreDataModel!
    var detailData : DetailDataModel!
    var viewController : DetailViewController?
    
    init(_ contact: CoreDataModel) {
        self.data = contact
    }
    
    func fetchDetails() {
        self.viewController?.populateIntialView(data)
        let serviceManager = ServiceManager.init()
        serviceManager.getDetails(self.data.url,onSuccess: {
            (detailData, error) in
            
            if detailData != nil {
                self.detailData = detailData!
                self.viewController?.populateOnSuccessView(self.detailData!)
            }
            else {
                self.viewController?.displayAlert(with: error)
            }
        })
    }
    
}
