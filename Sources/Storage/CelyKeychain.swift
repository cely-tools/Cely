//
//  CelyKeychain.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 8/7/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

internal struct CelyKeychain {
    // query to identify Cely Credentials
    private let baseQuery: [String: Any] = [
        kSecClass as String: kSecClassInternetPassword,
        kSecAttrLabel as String: "cely.secure.store.key",
        kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
    ]

    private var searchQuery: [String: Any] {
        var queryCopy = baseQuery
        queryCopy[kSecMatchLimit as String] = kSecMatchLimitOne
        queryCopy[kSecReturnAttributes as String] = true
        queryCopy[kSecReturnData as String] = true
        return queryCopy
    }

    func clearKeychain() -> StorageResult {
        let status = SecItemDelete(baseQuery as CFDictionary)
        let errorStatus = CelySecureStatus(status: status)
        guard errorStatus == .success
        else { return StorageResult.fail(errorStatus) }
        return .success
    }

    func getCredentials() throws -> [String: Any] {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        guard status == errSecSuccess else { throw CelySecureStatus(status: status) }

        do {
            guard let existingItem = item as? [String: Any],
                let secureData = existingItem[kSecValueData as String] as? Data,
                let loadedDictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(secureData) as? [String: Any]
            else { throw CelySecureStatus.decode }
            return loadedDictionary
        }
    }

    func set(_ secrets: [String: Any]) -> StorageResult {
        var queryCopy = baseQuery
        let storeData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        queryCopy[kSecValueData as String] = storeData

        // try adding first
        let status: OSStatus = SecItemAdd(queryCopy as CFDictionary, nil)
        let code = CelySecureStatus(status: status)
        if code == .success {
            return .success
        } else if code == .duplicateItem {
            // already exists, should update instead
            return update(secrets: secrets)
        }

        return .fail(code)
    }

    private func update(secrets: [String: Any]) -> StorageResult {
        let secretData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        let updateDictionary = [kSecValueData as String: secretData]
        let status: OSStatus = SecItemUpdate(baseQuery as CFDictionary, updateDictionary as CFDictionary)
        let code = CelySecureStatus(status: status)
        if code == .success {
            return .success
        }
        return .fail(code)
    }
}