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
internal let kStoreKey = "cely.secure.store.key"

internal class CelySecureStorage {
    var store: [String : Any] = [:]

    init() {
        setupStore()
    }

    func setupStore() {
        if let userData = getStore() {
            store = userData
        }
    }

    func clearStorage() {
        let query:[String: AnyObject] = [kSecClass as String : kSecClassGenericPassword]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Latch failed to reset keychain, error: \(status)")
        } else {
            store = [:]
        }
    }

    private func getStore() -> [String: Any]? {
        let query = setupKeychainQueryDictionary(withAdditional: [
            String(kSecMatchLimit): kSecMatchLimitOne,
            String(kSecReturnAttributes): true,
            String(kSecReturnData): true
        ])
        
        var item: CFTypeRef?
        let statusCode = SecItemCopyMatching(query as CFDictionary, &item)
        let status = LocksmithError(fromStatusCode: Int(statusCode))
        guard let code = status, code == .noError else {
            return nil
        }
        
        if let existingItem = item as? [String: Any],
            let store = existingItem[String(kSecValueData)] as? Data {
            if let loadedDictionary = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(store) as? [String : Any] {
                return loadedDictionary
            }
            return nil
        }
        return nil
    }
    
    private func setupKeychainQueryDictionary(withAdditional query: [String : Any] = [:]) -> [String: Any] {
        return [
            String(kSecClass):kSecClassGenericPassword,
            String(kSecAttrService): kCelyLocksmithService,
            String(kSecAttrAccount): kCelyLocksmithAccount,
            String(kSecAttrAccessible): kSecAttrAccessibleWhenUnlocked,
            String(kSecAttrGeneric): kStoreKey.data(using: String.Encoding.utf8)!
        ].merging(query) { (_, new) in new }
    }


    func set(_ value: Any, forKey key: String) -> StorageResult {
        var storeCopy = store
        storeCopy[key] = value
        let storeData = NSKeyedArchiver.archivedData(withRootObject: storeCopy)
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(withAdditional: [
            String(kSecValueData): storeData
        ])
        
        let status: OSStatus = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)

        if status == errSecSuccess {
            store[key] = value
            return .success
        } else if status == errSecDuplicateItem {
            return update(value, forKey: key)
        } else {
            return .fail(LocksmithError(fromStatusCode: Int(status))!)
        }
    }

    private func update(_ value: Any, forKey key: String) -> StorageResult {
        let keychainQueryDictionary = setupKeychainQueryDictionary()
        var storeCopy = store
        storeCopy[key] = value
        
        let valueData = value is Data ? value : NSKeyedArchiver.archivedData(withRootObject: storeCopy)
        let updateDictionary = [String(kSecValueData): valueData]

        let status: OSStatus = SecItemUpdate(keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary)

        if status == errSecSuccess {
            store[key] = value
            return .success
        } else {
            let err = LocksmithError(fromStatusCode: Int(status))!
            return .fail(err)
        }
    }

    func get(_ key: String) -> Any? {
        if let value = store[key] {
            return value
        }

        return nil
    }
}
