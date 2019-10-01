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
                    let tokenResult = User.save("FAKETOKEN:\(username)\(password)", as: .token)
                    switch tokenResult {
                    case .success:
                        let credentialResult = Cely.credentials.set(
                            username: username,
                            password: password,
                            server: "api.example.com",
                            accessibility: [
                                .biometricsIfPossible,
                                .thisDeviceOnly,
                            ]
                        )

                        switch credentialResult {
                        case .success:
                            Cely.changeStatus(to: .loggedIn)
                        case let .failure(error):
                            print("Cely store credentials error: \(error)")
                        }
                    case let .failure(error):
                        print("tokenResult Error: \(error)")
                    }
                }
            },
            .celyAnimator: CustomAnimator(),
        ])

        return true
    }
}
