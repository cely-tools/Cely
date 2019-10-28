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
            .loginViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BiometricLoginViewController"),
        ])

        return true
    }
}
