//
//  CelyStorage.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
internal let kCelyDomain = "cely.storage"

public class CelyStorage {
    // MARK: - Variables
    static let sharedInstance = CelyStorage()

    var secureStorage: [String : Any?] = [:]
    var storage: [String : [String : Any]]  = [:]
    init() {
        /// TODO: Need to clean up all this.
        let store = UserDefaults().persistentDomain(forName: kCelyDomain) ?? ["store": [:]]
        UserDefaults().setPersistentDomain(store, forName: kCelyDomain)
        UserDefaults().synchronize()
        if let store = store as? [String : [String : Any]] {
            storage = store
        }
    }

    /// Removes all data from both `secureStorage` and regular `storage`
    func removeAllData() {
        CelyStorage.sharedInstance.secureStorage = [:]
        UserDefaults().removePersistentDomain(forName: kCelyDomain)
        CelyStorage.sharedInstance.storage = [:]
    }

    /// Saves data to storage
    ///
    /// - parameter value:  `Any?` object you want to save
    /// - parameter key:    `String`
    /// - parameter secure: `Boolean`: If you want to store the data securely. Set to `True` by default
    ///
    /// - returns: `Boolean` on whether or not it successfully saved
    func set(_ value: Any?, forKey key: String, securely secure: Bool = false) -> Bool {
        guard let val = value else { return false }
        if secure {
            CelyStorage.sharedInstance.secureStorage[key] = val
        } else {
            CelyStorage.sharedInstance.storage["store"]?[key] = val
            UserDefaults().setPersistentDomain(CelyStorage.sharedInstance.storage, forName: kCelyDomain)
            UserDefaults().synchronize()
        }
        return true
    }

    /// Retrieve user data from key
    ///
    /// - parameter key: String
    ///
    /// - returns: Data For key value
    func get(_ key: String) -> Any? {
        if let value = CelyStorage.sharedInstance.secureStorage[key] {
            return value
        } else if let value = CelyStorage.sharedInstance.storage["store"]?[key] {
            return value
        }

        return nil
    }
}
