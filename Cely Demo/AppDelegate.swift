//
//  AppDelegate.swift
//  Cely Demo
//
//  Created by Fabian Buentello on 3/27/17.
//  Copyright © 2017 Cely. All rights reserved.
//

import Cely
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Cely.setup(with: window!, forModel: User(), requiredProperties: [.token], withOptions: [
            .loginCompletionBlock: { (username: String, password: String) in
                if username == "asdf", password == "asdf" {
                    if case .success = User.save("FAKETOKEN:\(username)\(password)", as: .token) {
                        Cely.changeStatus(to: .loggedIn)
                    }
                }
            },
            .celyAnimator: CustomAnimator(),
        ])

        return true
    }
}
