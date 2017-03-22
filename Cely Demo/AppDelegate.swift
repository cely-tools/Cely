//
//  AppDelegate.swift
//  Cely Demo
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit
import Cely

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Cely.setup(with: window!, forModel: User(), requiredProperties: [.token], withOptions: [
            .loginCompletionBlock: { (username: String, password: String) in
                if username == "asdf" && password == "asdf" {
                    User.save("FAKETOKEN:\(username)\(password)", as: .token)
                    Cely.changeStatus(to: .loggedIn)
                }
            },
            .celyAnimator: CustomAnimator()
            ])

        return true
    }
}
