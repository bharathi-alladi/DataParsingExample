//
//  Router.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 8/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

class Router {
    
    static var sharedInstance = Router()
    
    var rootNavigationController : UINavigationController?
    
    func appLaunch(_ window: UIWindow) {
        
        let viewModel = ListViewModel.init()
        let intialView = ListViewController.initWithViewModel(viewModel)
        
        rootNavigationController = UINavigationController.init(rootViewController: intialView)
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
    
    
    func routeToDetailView(_ contact : CoreDataModel) {
        
        let viewModel = DetailViewModel.init(contact)
        let detailView = DetailViewController.initWithViewModel(viewModel)
        
        rootNavigationController?.pushViewController(detailView, animated: true)
    }
    
}
