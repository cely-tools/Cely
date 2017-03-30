//
//  CelyStorage.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

internal let kCelyDomain = "cely.storage"
internal let kCelyLocksmithAccount = "cely.secure.storage"
internal let kCelyLocksmithService = "cely.secure.service"
internal let kStore = "store"
internal let kPersisted = "persisted"
internal let kLaunchedBefore = "launchedBefore"

public class CelyStorage: CelyStorageProtocol {
    // MARK: - Variables
    static let sharedInstance = CelyStorage()

    var secureStorage: [String : Any] = [:]
    var storage: [String : [String : Any]]  = [:]
    public init() {

        // Check if this is first launch of app
        let persistedDict = UserDefaults.standard.persistentDomain(forName: kCelyDomain)?[kPersisted] as? [String: Any]
        let launchedBefore = persistedDict?[kLaunchedBefore] as? Bool
        if launchedBefore == nil {
            // If not, Clear everything and set flag
            UserDefaults.standard.setPersistentDomain([kStore: [:], kPersisted: [kLaunchedBefore:true]], forName: kCelyDomain)
            UserDefaults.standard.synchronize()

            // Clear Locksmith
            do {
                try Locksmith.deleteDataForUserAccount(userAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService)
            } catch {}
        }

        setupStorage()
        setupSecureStorage()
    }

    fileprivate func setupStorage() {
        let store = UserDefaults.standard.persistentDomain(forName: kCelyDomain) ?? [kStore: [:], kPersisted: [:]]
        UserDefaults.standard.setPersistentDomain(store, forName: kCelyDomain)
        UserDefaults.standard.synchronize()
        if let store = store as? [String : [String : Any]] {
            storage = store
        }
    }

    fileprivate func setupSecureStorage() {
        if let userData = Locksmith.loadDataForUserAccount(userAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService) {
            secureStorage = userData
        }
    }

    /// Removes all data from both `secureStorage` and regular `storage`
    public func removeAllData() {
        CelyStorage.sharedInstance.secureStorage = [:]
        CelyStorage.sharedInstance.storage[kStore] = [:]
        UserDefaults.standard.setPersistentDomain(CelyStorage.sharedInstance.storage, forName: kCelyDomain)
        UserDefaults.standard.synchronize()
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService)
        } catch {
            // handle the error
            print("error: \(error.localizedDescription)")
        }
    }

    /// Saves data to storage
    ///
    /// - parameter value:  `Any?` object you want to save
    /// - parameter key:    `String`
    /// - parameter secure: `Boolean`: If you want to store the data securely. Set to `True` by default
    /// - parameter persisted: `Boolean`: Keep data after logout
    ///
    /// - returns: `Boolean` on whether or not it successfully saved
    public func set(_ value: Any?, forKey key: String, securely secure: Bool = false, persisted: Bool = false) -> StorageResult {
        guard let val = value else { return .fail(.undefined) }
        if secure {
            var currentStorage = CelyStorage.sharedInstance.secureStorage
            currentStorage[key] = val
            CelyStorage.sharedInstance.secureStorage = currentStorage
            do {
                try Locksmith.updateData(data: currentStorage, forUserAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService)
                return .success
                
            } catch let storageError as LocksmithError {
                return .fail(storageError)
            } catch {
                return .fail(.undefined)
            }
        } else {
            if persisted {
                CelyStorage.sharedInstance.storage[kPersisted]?[key] = val
                CelyStorage.sharedInstance.storage[kStore]?[key] = nil
            } else {
                CelyStorage.sharedInstance.storage[kPersisted]?[key] = nil
                CelyStorage.sharedInstance.storage[kStore]?[key] = val
            }
            UserDefaults.standard.setPersistentDomain(CelyStorage.sharedInstance.storage, forName: kCelyDomain)
            UserDefaults.standard.synchronize()
        }
        return .success
    }

    /// Retrieve user data from key
    ///
    /// - parameter key: String
    ///
    /// - returns: Data For key value
    public func get(_ key: String) -> Any? {
        if let value = CelyStorage.sharedInstance.secureStorage[key] {
            return value
        } else if let value = CelyStorage.sharedInstance.storage[kStore]?[key] {
            return value
        } else if let value = CelyStorage.sharedInstance.storage[kPersisted]?[key] {
            return value
        }

        return nil
    }
}
