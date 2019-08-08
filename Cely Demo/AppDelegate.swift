//
//  AppDelegate.swift
//  Cely Demo
//
//  Created by Fabian Buentello on 3/27/17.
//  Copyright © 2017 ChaiOne. All rights reserved.
//

import UIKit
import Cely

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Cely.setup(with: window!, forModel: User(), requiredProperties: [.token], withOptions: [
            .appEntryViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController"),
//            .loginViewController: UIStoryboard(name: "TestStoryboard", bundle: nil).instantiateInitialViewController(),
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
