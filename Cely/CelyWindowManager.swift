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
    static let sharedInstance = CelyWindowManager()
    var window: UIWindow?

    fileprivate init() {
        addObserver(#selector(homeScreen), action: .LoggedIn)
        addObserver(#selector(loginScreen), action: .LoggedOut)
    }

    // MARK: - Private Methods

    // MARK: - Public Methods
    func addObserver(_ selector: Selector, action: CelyAction) {
        NotificationCenter.default
            .addObserver(self,
                         selector: selector,
                         name: NSNotification.Name(rawValue: action.rawValue),
                         object: nil)
    }

    @objc private func homeScreen() {
        CelyWindowManager.sharedInstance.window!.rootViewController = CelyWindowManager.showHomeScreen()
    }

    @objc private func loginScreen() {
        CelyWindowManager.sharedInstance.window!.rootViewController = CelyWindowManager.showLoginScreen()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func showScreen(_ from: Cely.Type) {
        let vc = from.isLoggedIn() ? CelyWindowManager.showHomeScreen() : CelyWindowManager.showLoginScreen()
        CelyWindowManager.sharedInstance.window!.rootViewController = vc
    }

    class func showLoginScreen() -> UIViewController? {

        let s = UIStoryboard(name: "Cely", bundle: Bundle(for: self))
        let vc = s.instantiateInitialViewController()
        return vc
    }

    class func showHomeScreen() -> UIViewController? {
        return UIStoryboard(name: "Main", bundle:Bundle.main).instantiateInitialViewController()
    }
}
