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

    /// Properties that are needed inorder for user to stay logged in.
    public static var requiredProperties: [CelyProperty] = []

    /// Sets up Cely within your application
    ///
    /// - parameter window:             `UIWindow` of your application.
    /// - parameter forModel:           The `Model` Cely will be storing.
    /// - parameter requiredProperties: `[CelyProperty]`: The properties that cely tests against to determine if a user is logged in.
    public static func setup<T: CelyUser, U: RawRepresentable>(with window: UIWindow?, forModel: T, requiredProperties:[U] = []) where T.Property == U {
        Cely.requiredProperties = requiredProperties.flatMap({"\($0.rawValue)"})

        CelyWindowManager.manager.window = window
        CelyWindowManager.manager.showScreen(forStatus: currentLoginStatus())
    }
}

extension Cely {

    /// Will return the `CelyStatus` of the current user.
    ///
    /// - parameter properties: Array of required properties that need to be in storage.
    ///
    /// - returns: `CelyStatus`. If `requiredProperties` are all in storage, it will return `.LoggedIn`, else `.LoggedOut`
    public static func currentLoginStatus(requiredProperties properties: [CelyProperty] = requiredProperties) -> CelyStatus {
        guard properties.count > 0 else { return .LoggedOut }

        let missingRequiredProperties = properties
            .map({return CelyStorage.get($0)})
            .contains(where: {$0 == nil})

        if missingRequiredProperties {
            return .LoggedOut
        } else {
            return .LoggedIn
        }
    }

    /// Returns stored data for key.
    ///
    /// - parameter key: String
    ///
    /// - returns: Returns data as an optional `Any`
    public static func get(key: String) -> Any? {
        return CelyStorage.get(key)
    }

    /// Saves data in storage
    ///
    /// - parameter value: data you want to save
    /// - parameter key:   String for the key
    ///
    /// - returns: `Boolean`: Whether or not your value was successfully set.
    @discardableResult public static func save(_ value: Any?, forKey key: String) -> Bool {
        return CelyStorage.set(value, forKey: key)
    }

    /// Perform action like `LoggedIn` or `LoggedOut`
    ///
    /// - parameter action: CelyStatus
    public static func userAction(_ status: CelyStatus) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: status.rawValue), object: nil)
    }


    /// Log user out
    public static func logout() {
        CelyStorage.removeAllData()
        userAction(.LoggedOut)
    }
}
