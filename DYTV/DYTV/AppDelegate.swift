//
//  AppDelegate.swift
//  DYTV
//
//  Created by djk on 17/2/23.
//  Copyright © 2017年 NQ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange;
        return true
    }

}

