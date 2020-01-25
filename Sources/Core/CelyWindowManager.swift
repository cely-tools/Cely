//
//  CelyManager.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

public class CelyWindowManager {
    // MARK: - Variables

    static let manager = CelyWindowManager()
    internal var window: UIWindow!

    internal var loginViewController: UIViewController!
    internal var homeViewController: UIViewController!
    public var loginStyle: CelyStyle!
    public var celyAnimator: CelyAnimator!

    public init() {}

    static func setup(window _window: UIWindow, withOptions options: [CelyOptions: Any?]? = [:]) {
        CelyWindowManager.manager.window = _window

        // Set the login Styles
        CelyWindowManager.manager.loginStyle = options?[.loginStyle] as? CelyStyle ?? DefaultSyle()

        // Set the HomeViewController
        CelyWindowManager.setHomeViewController(options?[.homeViewController] as? UIViewController)

        // Set the LoginViewController
        CelyWindowManager.setLoginViewController(options?[.loginViewController] as? UIViewController)

        // Set the Transition Animator
        CelyWindowManager.manager.celyAnimator = options?[.celyAnimator] as? CelyAnimator ?? DefaultAnimator()

        CelyWindowManager.manager.addObserver(#selector(showScreenWith), action: .loggedIn)
        CelyWindowManager.manager.addObserver(#selector(showScreenWith), action: .loggedOut)
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
            if status == .loggedIn {
                CelyWindowManager.manager.celyAnimator.loginTransition(
                    to: CelyWindowManager.manager.homeViewController,
                    with: CelyWindowManager.manager.window
                )
            } else {
                CelyWindowManager.manager.celyAnimator.logoutTransition(
                    to: CelyWindowManager.manager.loginViewController,
                    with: CelyWindowManager.manager.window
                )
            }
        }
    }

    static func setHomeViewController(_ viewController: UIViewController?) {
        CelyWindowManager.manager.homeViewController = viewController ?? UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    }

    static func setLoginViewController(_ viewController: UIViewController?) {
        CelyWindowManager.manager.loginViewController = viewController ?? UIStoryboard(name: "Cely", bundle: Bundle(for: CelyWindowManager.self)).instantiateInitialViewController()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
