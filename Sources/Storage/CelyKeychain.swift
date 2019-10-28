//
//  CelyKeychain.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 9/28/19.
//  Copyright © 2019 ChaiOne. All rights reserved.
//

import Foundation

protocol KeychainProtocol {
    func get(query: KeychainObject) -> Result<KeychainObject, Error>
    func set(query: KeychainObject) throws
    func delete(query: KeychainObject) throws
}

internal struct CelyKeychain: KeychainProtocol {
    func get(query: KeychainObject) -> Result<KeychainObject, Error> {
        let newQuery = query.toGetMap()
        var someItem: RawDictionary?
        let status = SecItemCopyMatching(newQuery as CFDictionary, &someItem)
        guard status == errSecSuccess else {
            return .failure(CelyStorageError(status: status))
        }

        guard let item = someItem else {
            return .failure(CelyStorageError.missingValue)
        }
        let celyQuery = KeychainObject.buildFromKeychain(dictionary: item)
        return .success(celyQuery)
    }

    func set(query: KeychainObject) throws {
        // try adding first
        let newQuery = query.toSetMap(withValue: true)
        let status: OSStatus = SecItemAdd(newQuery as CFDictionary, nil)
        let code = CelyStorageError(status: status)
        switch code {
        case .noError: return
        case .duplicateItem: return try update(query)
        default: throw code
        }
    }

    private func update(_ query: KeychainObject) throws {
        guard let valueData = query.value as CFData? else { throw CelyStorageError.invalidValue }

        let status: OSStatus = SecItemUpdate(query.toSetMap(withValue: false) as CFDictionary, [kSecValueData: valueData] as CFDictionary)
        let code = CelyStorageError(status: status)
        guard code == .noError else {
            throw code
        }
    }

    func delete(query: KeychainObject) throws {
        let status = SecItemDelete(query.toLookupMap() as CFDictionary)
        let errorStatus = CelyStorageError(status: status)
        guard errorStatus == .noError else {
            throw errorStatus
        }
    }
}
