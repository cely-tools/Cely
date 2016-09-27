//
//  Cely.swift
//  Cely
//
//  Created by Fabian Buentello on 7/31/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import UIKit

public typealias CelyProperties = String
public typealias CelyCommands = String

public protocol CelyUser {
    associatedtype Property : RawRepresentable
}

public enum CelyAction: CelyCommands {
    case LoggedIn = "c1Action.login.user"
    case LoggedOut = "c1Action.logout.user"
}

public struct Cely {

    fileprivate init() {}
    fileprivate static var requiredProperties: [CelyProperties] = []

    fileprivate static var Defaults:UserDefaults?
    fileprivate static var CelyIsSetup: Bool {
        return Defaults != nil
    }

    public static func setup(with window: UIWindow?) {
        Defaults = UserDefaults.standard
        
        CelyClass.sharedInstance.window = window
        CelyClass.sharedInstance.showScreen(self)
    }

    public static func setup<T: CelyUser, U: RawRepresentable>(with window: UIWindow?, forModel: T, requiredProperties:[U]) where T.Property == U {
        Cely.requiredProperties = requiredProperties.flatMap({"\($0.rawValue)"})
        setup(with: window)
    }
}

public extension Cely {

    static func userAction(_ action: CelyAction) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: action.rawValue), object: nil)
    }

    static func logout() {
        guard CelyIsSetup else { return }

        Defaults?.removeObject(forKey: "username")
        userAction(.LoggedOut)
    }

    static func isLoggedIn() -> Bool {

        guard requiredProperties.count > 0 else { return false }

        let missingRequiredProperties = requiredProperties
            .map({return get($0)})
            .contains(where: {$0 == nil})

        return !missingRequiredProperties
    }

    static func save(_ property: String, value: Any?) {
        Defaults?.set(value, forKey: property)
        Defaults?.synchronize()
    }

    static func get(_ property: String) -> Any? {
        return Defaults?.object(forKey: property) as Any?
    }
}

class CelyClass {
    static let sharedInstance = CelyClass()
    var window: UIWindow?

    fileprivate init() {
        func addObserver(_ selector: Selector, action: CelyAction) {
            NotificationCenter.default
                .addObserver(self, selector: selector, name: NSNotification.Name(rawValue: action.rawValue), object: nil)
        }
        addObserver(#selector(homeScreen), action: .LoggedIn)
        addObserver(#selector(loginScreen), action: .LoggedOut)
    }

    @objc func homeScreen() {
        CelyClass.sharedInstance.window!.rootViewController = CelyClass.showHomeScreen()
    }

    @objc func loginScreen() {
        CelyClass.sharedInstance.window!.rootViewController = CelyClass.showLoginScreen()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func showScreen(_ from: Cely.Type) {
        CelyClass.sharedInstance.window!.rootViewController = from.isLoggedIn() ? CelyClass.showHomeScreen() : CelyClass.showLoginScreen()
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
