//
//  CelyManager.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

public class CelyWindowManager {

    // MARK: - Variables
    static let manager = CelyWindowManager()
    internal var window: UIWindow!

    public var loginStoryboard: UIStoryboard!
    public var homeStoryboard: UIStoryboard!

    private init() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            // Code only executes when tests are NOT running because it cant find "Main" storyboard
            loginStoryboard = UIStoryboard(name: "Cely", bundle: Bundle(for: type(of: self)))
            homeStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        }
    }

    static func setup(window _window: UIWindow, withOptions options: [CelyOptions : Any?]? = [:]) {
        CelyWindowManager.manager.window = _window

        // Set the HomeStoryboard
        CelyWindowManager.setHomeStoryboard(options?[.HomeStoryboard] as? UIStoryboard)

        // Set the LoginStoryboard
        CelyWindowManager.setLoginStoryboard(options?[.LoginStoryboard] as? UIStoryboard)

        CelyWindowManager.manager.addObserver(#selector(showScreenWith), action: .LoggedIn)
        CelyWindowManager.manager.addObserver(#selector(showScreenWith), action: .LoggedOut)
    }

    // MARK: - Private Methods

    private func addObserver(_ selector: Selector, action: CelyStatus) {
        NotificationCenter.default
            .addObserver(self,
                         selector: selector,
                         name: NSNotification.Name(rawValue: action.rawValue),
                         object: nil)
    }

    // MARK: - Public Methods

    @objc func showScreenWith(notification: NSNotification) {
        if let status = notification.object as? CelyStatus {
            if status == .LoggedIn {
                CelyWindowManager.manager.window.rootViewController = CelyWindowManager.manager.homeStoryboard.instantiateInitialViewController()
            } else {
                CelyWindowManager.manager.window.rootViewController = CelyWindowManager.manager.loginStoryboard.instantiateInitialViewController()
            }
        }
    }

    static func setHomeStoryboard(_ storyboard: UIStoryboard?) {
        CelyWindowManager.manager.homeStoryboard = storyboard ?? CelyWindowManager.manager.homeStoryboard
    }

    static func setLoginStoryboard(_ storyboard: UIStoryboard?) {
        CelyWindowManager.manager.loginStoryboard = storyboard ?? CelyWindowManager.manager.loginStoryboard
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
