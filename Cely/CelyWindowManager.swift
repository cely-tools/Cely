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
    internal var window: UIWindow!

    public var loginScreen: UIViewController!
    public lazy var homeScreen: UIViewController! = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    class var _defaultLoginScreen: UIViewController? {
        let s = UIStoryboard(name: "Cely", bundle: Bundle(for: self))
        let vc = s.instantiateInitialViewController()
        return vc
    }

    fileprivate init() {}

    static func setup(window _window: UIWindow, withLoginScreen vc: UIViewController? = CelyWindowManager._defaultLoginScreen) {
        CelyWindowManager.manager.window = _window
        CelyWindowManager.manager.loginScreen = vc
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
                CelyWindowManager.manager.window.rootViewController = CelyWindowManager.manager.homeScreen
            } else {
                CelyWindowManager.manager.window.rootViewController = CelyWindowManager.manager.loginScreen
            }
        }
    }

    class func setHomeScreen(to vc: UIViewController! = manager.homeScreen) {
        CelyWindowManager.manager.homeScreen = vc
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
