//
//  AppDelegate.swift
//  Cely Demo
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit
import Cely
import Locksmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Cely.setup(with: window!, forModel: User.ref, requiredProperties:[.Token])

        Cely.setup(with: window!, forModel: User.ref, requiredProperties: [.Token], withOption: [
            .Storage: CelyStorage(),
            .WindowManager: CelyWindowManager(),
            .HomeStoryboard: UIStoryboard(name: "Main", bundle: nil),
            .LoginStoryboard: UIStoryboard(name: "Main", bundle: nil),
            .LoginCompletionBlock: { (username: String?, password: String?) in
                print("username: \(username), password: \(password)")
            }
        ])
        
        return true
    }
}
