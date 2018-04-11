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

    fileprivate init() {}
    public typealias CelyLoginCompletion = (_ username: String, _ password: String) -> Void
    /// Properties that are needed inorder for user to stay logged in.
    public static var requiredProperties: [CelyProperty] = []

    /// A `Storage` instance
    public static var store: CelyStorageProtocol = CelyStorage.sharedInstance

    /// A Completion Block that is expecting a `username:String` and a `password:String`
    public static var loginCompletionBlock: CelyLoginCompletion?

    /// Sets up Cely within your application
    ///
    /// - parameter window:             `UIWindow` of your application.
    /// - parameter forModel:           The `Model` Cely will be storing.
    /// - parameter requiredProperties: `[CelyProperty]`: The properties that cely tests against to determine if a user is logged in.
    /// - parameter withOptions:         Dictionary of options to pass into cely upon setup. Please refer to `CelyOptions` to view all options.
    public static func setup<T: CelyUser, U>(with window: UIWindow?, forModel: T, requiredProperties:[U] = [], withOptions options: [CelyOptions : Any?]? = [:]) where T.Property == U {

        Cely.requiredProperties = requiredProperties.map({"\($0.rawValue)"})

        Cely.loginCompletionBlock = options?[.loginCompletionBlock] as? CelyLoginCompletion
        store = options?[.storage] as? CelyStorageProtocol ?? store

        if let window = window {
            CelyWindowManager.setup(window: window, withOptions: options)
            changeStatus(to: currentLoginStatus())
        }
    }
}

extension Cely {

    /// Will return the `CelyStatus` of the current user.
    ///
    /// - parameter properties: Array of required properties that need to be in store.
    /// - parameter store:    Storage `Cely` will be using. Defaulted to `Storage`
    ///
    /// - returns: `CelyStatus`. If `requiredProperties` are all in store, it will return `.LoggedIn`, else `.LoggedOut`
    public static func currentLoginStatus(requiredProperties properties: [CelyProperty] = requiredProperties, fromStorage store: CelyStorageProtocol = store) -> CelyStatus {
        guard properties.count > 0 else { return .loggedOut }

        let missingRequiredProperties = properties
            .map({return store.get($0)})
            .contains(where: {$0 == nil})

        if missingRequiredProperties {
            return .loggedOut
        } else {
            return .loggedIn
        }
    }

    /// Returns stored data for key.
    ///
    /// - parameter key:    String
    /// - parameter store: Object that conforms to the CelyStorageProtocol protocol that `Cely` will be using. Defaulted to `Cely`'s instance of store
    ///
    /// - returns: Returns data as an optional `Any`
    public static func get(key: String, fromStorage store: CelyStorageProtocol = store) -> Any? {
        return store.get(key)
    }

    /// Saves data in store
    ///
    /// - parameter value:   data you want to save
    /// - parameter key:     String for the key
    /// - parameter store: Storage `Cely` will be using. Defaulted to `Storage`
    /// - parameter secure: `Boolean`: Store data securely
    /// - parameter persist: `Boolean`: Keep data after logout
    ///
    /// - returns: `Boolean`: Whether or not your value was successfully set.
    @discardableResult public static func save(_ value: Any?, forKey key: String, toStorage store: CelyStorageProtocol = store, securely secure: Bool = false, persisted persist: Bool = false) -> StorageResult {
        return store.set(value, forKey: key, securely: secure, persisted: persist)
    }

    /// Perform action like `LoggedIn` or `LoggedOut`
    ///
    /// - parameter status: CelyStatus
    public static func changeStatus(to status: CelyStatus) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: status.rawValue), object: status)
    }

    /// Log user out
    ///
    /// - parameter store: Storage `Cely` will be using. Defaulted to `CelyStorageProtocol`
    public static func logout(useStorage store: CelyStorageProtocol = store) {
        store.removeAllData()
        changeStatus(to: .loggedOut)
    }

    /// Returns whether or not the user is logged in
    ///
    /// - returns: `Boolean`
    public static func isLoggedIn() -> Bool {
        return currentLoginStatus() == .loggedIn
    }
}
