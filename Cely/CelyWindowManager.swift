//
//  CelyManager.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

class CelyWindowManager {

    // MARK: - Variables
    static let manager = CelyWindowManager()
    var window: UIWindow!

    fileprivate init() {}

    static func setup(window _window: UIWindow) {
        CelyWindowManager.manager.window = _window
        // TODO: Replace selectors with blocks that I can access with test
        CelyWindowManager.manager.addObserver(#selector(goToHomeScreen), action: .LoggedIn)
        CelyWindowManager.manager.addObserver(#selector(goToLoginScreen), action: .LoggedOut)
    }
    // MARK: - Private Methods

    // MARK: - Public Methods
    func addObserver(_ selector: Selector, action: CelyStatus) {
        NotificationCenter.default
            .addObserver(self,
                         selector: selector,
                         name: NSNotification.Name(rawValue: action.rawValue),
                         object: nil)
    }

    /// Bring user to home screen
    @objc private func goToHomeScreen() {
        CelyWindowManager.manager.window.rootViewController = CelyWindowManager.showHomeScreen()
    }

    /// Bring user to login screen
    @objc private func goToLoginScreen() {
        CelyWindowManager.manager.window.rootViewController = CelyWindowManager.showLoginScreen()
    }


    /// Show screens Depending on user's current status
    ///
    /// - parameter from: `CelyStatus`
    func showScreen(forStatus status: CelyStatus) {
        if status == .LoggedIn {
            goToHomeScreen()
        } else {
            goToLoginScreen()
        }
    }

    class func showLoginScreen() -> UIViewController? {

        let s = UIStoryboard(name: "Cely", bundle: Bundle(for: self))
        let vc = s.instantiateInitialViewController()
        return vc
    }

    class func showHomeScreen() -> UIViewController? {
        return UIStoryboard(name: "Main", bundle:Bundle.main).instantiateInitialViewController()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
