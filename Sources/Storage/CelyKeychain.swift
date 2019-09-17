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

    func clearKeychain() -> Result<Void, CelyStorageError> {
        let status = SecItemDelete(baseQuery as CFDictionary)
        let errorStatus = CelyStorageError(status: status)
        guard errorStatus == .noError else { return .failure(errorStatus) }
        return .success(())
    }

    func getCredentials() throws -> [String: Any] {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        guard status == errSecSuccess else { throw CelyStorageError(status: status) }

        do {
            guard let existingItem = item as? [String: Any],
                let secureData = existingItem[kSecValueData as String] as? Data,
                let loadedDictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(secureData) as? [String: Any]
            else { throw CelyStorageError.decode }
            return loadedDictionary
        }
    }

    func set(_ secrets: [String: Any]) -> Result<Void, CelyStorageError> {
        var queryCopy = baseQuery
        let storeData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        queryCopy[kSecValueData as String] = storeData

        // try adding first
        let status: OSStatus = SecItemAdd(queryCopy as CFDictionary, nil)
        let code = CelyStorageError(status: status)
        switch code {
        case .noError:
            return .success(())
        case .duplicateItem:
            return update(secrets: secrets)
        default:
            return .failure(code)
        }
    }

    private func update(secrets: [String: Any]) -> Result<Void, CelyStorageError> {
        let secretData = NSKeyedArchiver.archivedData(withRootObject: secrets)
        let updateDictionary = [kSecValueData as String: secretData]
        let status: OSStatus = SecItemUpdate(baseQuery as CFDictionary, updateDictionary as CFDictionary)
        let code = CelyStorageError(status: status)
        if code == .noError {
            return .success(())
        }
        return .failure(code)
    }
}
