//
//  AppDelegate.swift
//  iOSConf
//
//  Created by Joshua Gretz on 10/31/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        BaseContainerConfiguration.configure()
        
        return true
    }
}

