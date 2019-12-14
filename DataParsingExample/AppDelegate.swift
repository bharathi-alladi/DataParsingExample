//
//  AppDelegate.swift
//  DataParsingExample
//
//  Created by Harsha Vardhan Pabbineedi on 22/11/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        window = UIWindow(frame: UIScreen.main.bounds)
        Router.sharedInstance.appLaunch(window!)
        return true
    }
    
}

