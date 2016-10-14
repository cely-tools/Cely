//
//  Cely.swift
//  Cely
//
//  Created by Fabian Buentello on 7/31/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import UIKit

public struct Cely {

    private init() {}
    static var requiredProperties: [CelyProperty] = []

    /// Sets up Cely within your application
    ///
    /// - parameter window:             `UIWindow` of your application.
    /// - parameter forModel:           The `Model` Cely will be storing.
    /// - parameter requiredProperties: `[CelyProperty]`: The properties that cely tests against to determine if a user is logged in.
    public static func setup<T: CelyUser, U: RawRepresentable>(with window: UIWindow?, forModel: T, requiredProperties:[U] = []) where T.Property == U {
        Cely.requiredProperties = requiredProperties.flatMap({"\($0.rawValue)"})

        CelyWindowManager.sharedInstance.window = window
        CelyWindowManager.sharedInstance.showScreen(self)
    }

    public static func setRequiredProperties(properties: [CelyProperty]) {

    }
}

public extension Cely {

    static func isLoggedIn() -> Bool {
        guard Cely.requiredProperties.count > 0 else { return false }

        let missingRequiredProperties = Cely.requiredProperties
            .map({return CelyStorage.get($0)})
            .contains(where: {$0 == nil})

        return !missingRequiredProperties
    }

    static func get(key: String) -> Any? {
        return CelyStorage.get(key)
    }

    static func set(_ value: Any?, key: String) {
        return CelyStorage.set(value, forKey: key)
    }
    
    static func userAction(_ action: CelyAction) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: action.rawValue), object: nil)
    }

    static func logout() {

        CelyStorage.removeAllData()
        userAction(.LoggedOut)
    }
}
