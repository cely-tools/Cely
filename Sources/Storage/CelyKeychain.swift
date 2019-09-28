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

    func clearKeychain() throws {
        let status = SecItemDelete(baseQuery as CFDictionary)
        let errorStatus = CelyStorageError(status: status)
        guard errorStatus == .noError else {
            throw errorStatus
        }
    }

    func getProtectedData() throws -> [String: Any] {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        let errorStatus = CelyStorageError(status: status)
        guard errorStatus == .noError else {
            throw errorStatus
        }

        guard let existingItem = item as? [String: Any],
            let secureData = existingItem[kSecValueData as String] as? Data,
            let loadedDictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(secureData) as? [String: Any]
        else {
            throw CelyStorageError.missingValue
        }

        return loadedDictionary
    }

    func set(_ secrets: [String: Any]) throws {
        var queryCopy = baseQuery
        let storeData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        queryCopy[kSecValueData as String] = storeData

        // try adding first
        let status = SecItemAdd(queryCopy as CFDictionary, nil)
        let errorStatus = CelyStorageError(status: status)

        switch errorStatus {
        case .noError: return
        case .duplicateItem: return try update(secrets: secrets)
        default: throw errorStatus
        }
    }

    private func update(secrets: [String: Any]) throws {
        let secretData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        let updateDictionary = [kSecValueData as String: secretData]
        let status = SecItemUpdate(baseQuery as CFDictionary, updateDictionary as CFDictionary)
        let errorStatus = CelyStorageError(status: status)
        guard errorStatus == .noError else {
            throw errorStatus
        }
    }
}
