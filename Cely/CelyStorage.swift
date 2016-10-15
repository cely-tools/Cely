//
//  CelyStorage.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import Locksmith

public class CelyStorage {
    // MARK: - Variables
    static let sharedInstance = CelyStorage()
    var secureStorage: [String : Any?] = [:]
    var storage: [String : Any?] = [:]
    private init() {}

    // Insecure storage


    /// Removes all data from both `secureStorage` and regular `storage`
    static func removeAllData() {
        CelyStorage.sharedInstance.secureStorage = [:]
        CelyStorage.sharedInstance.storage = [:]
    }


    /// Saves data to storage
    ///
    /// - parameter value:  `Any?` object you want to save
    /// - parameter key:    `String`
    /// - parameter secure: `Boolean`: If you want to store the data securely. Set to `True` by default
    ///
    /// - returns: `Boolean` on whether or not it successfully saved
    static func set(_ value: Any?, forKey key: String, securely secure: Bool = true) -> Bool {
        if secure {
            CelyStorage.sharedInstance.secureStorage[key] = value
        } else {
            CelyStorage.sharedInstance.storage[key] = value
        }
        return true
    }

    static func get(_ key: String) -> Any? {
        if let value = CelyStorage.sharedInstance.secureStorage[key] {
            return value
        } else if let value = CelyStorage.sharedInstance.storage[key] {
            return value
        }

        return nil
    }
}
