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

//    public var loginStoryboard: UIStoryboard!
//    public var homeStoryboard: UIStoryboard!
    internal var loginViewController: UIViewController!
    internal var appEntryViewController: UIViewController!
    public var loginStyle: CelyStyle!
    public var celyAnimator: CelyAnimator!

    public init() {}

    static func setup(window _window: UIWindow, withOptions options: [CelyOptions : Any?]? = [:]) {
        CelyWindowManager.manager.window = _window

        // Set the login Styles
        CelyWindowManager.manager.loginStyle = options?[.loginStyle] as? CelyStyle ?? DefaultSyle()

        // Set the HomeStoryboard
//        CelyWindowManager.setHomeStoryboard(options?[.homeStoryboard] as? UIStoryboard)
        CelyWindowManager.setAppEntryViewController(options?[.appEntryViewController] as? UIViewController)
        
        // Set the LoginStoryboard
//        CelyWindowManager.setLoginStoryboard(options?[.loginStoryboard] as? UIStoryboard)

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
                    to: CelyWindowManager.manager.appEntryViewController, //CelyWindowManager.manager.homeStoryboard.instantiateInitialViewController(),
                    with: CelyWindowManager.manager.window
                )
            } else {
                CelyWindowManager.manager.celyAnimator.logoutTransition(
                    to: CelyWindowManager.manager.loginViewController, //CelyWindowManager.manager.loginStoryboard.instantiateInitialViewController(),
                    with: CelyWindowManager.manager.window
                )
            }
        }
    }

//    static func setHomeStoryboard(_ storyboard: UIStoryboard?) {
//        CelyWindowManager.manager.homeStoryboard = storyboard ?? UIStoryboard(name: "Main", bundle: Bundle.main)
//    }
    
    static func setAppEntryViewController(_ viewController: UIViewController?) {
        CelyWindowManager.manager.appEntryViewController = viewController ?? UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
    }

//    static func setLoginStoryboard(_ storyboard: UIStoryboard?) {
//        CelyWindowManager.manager.loginStoryboard = storyboard ?? UIStoryboard(name: "Cely", bundle: Bundle(for: CelyWindowManager.self))
//    }

    static func setLoginViewController(_ viewController: UIViewController?) {
        CelyWindowManager.manager.loginViewController = viewController ?? UIStoryboard(name: "Cely", bundle: Bundle(for: CelyWindowManager.self)).instantiateInitialViewController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
