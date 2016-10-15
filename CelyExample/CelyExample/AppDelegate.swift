//
//  AppDelegate.swift
//  CelyExample
//
//  Created by Fabian Buentello on 9/27/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit
import Cely

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Cely.setup(with: window, forModel: User.ref, requiredProperties: [.Token])

        return true
    }
}
