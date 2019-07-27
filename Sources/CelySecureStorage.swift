//
//  CelySecureStorage.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 7/27/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

internal let kCelyLocksmithAccount = "cely.secure.storage"
internal let kCelyLocksmithService = "cely.secure.service"
internal class CelySecureStorage {
    var store: [String : Any] = [:]
    
    init() {
        setupStore()
    }
    
    func setupStore() {
        if let userData = Locksmith.loadDataForUserAccount(userAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService) {
            store = userData
        }
    }
    
    func clearStorage() {
        // Clear Locksmith
        do {
            store = [:]
            try Locksmith.deleteDataForUserAccount(userAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService)
        } catch {
            // handle the error
            print("error: \(error.localizedDescription)")
        }
    }
    
    func set(_ value: Any, forKey key: String) -> StorageResult {
        do {
            store[key] = value
            
            try Locksmith.updateData(data: store, forUserAccount: kCelyLocksmithAccount, inService: kCelyLocksmithService)
            return .success
            
        } catch let storageError as LocksmithError {
            return .fail(storageError)
        } catch {
            return .fail(.undefined)
        }
    }
    
    func get(_ key: String) -> Any? {
        if let value = store[key] {
            return value
        }
        
        return nil
    }
}
