//
//  CelySecureStorage.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 7/27/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

internal class CelySecureStorage: CelyStorageProtocol {
    var store: [String: Any] = [:]
    private let celyKeychain = CelyKeychain()

    init() {
        let protectedDataQuery: Any = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: kProtectedDataAccount,
            kSecAttrLabel: kCelySecureStoreLabel,
        ]

        let object = KeychainObject.buildFromKeychain(dictionary: protectedDataQuery as AnyObject)
        let existingResult = celyKeychain.get(query: object)

        if case let .success(protectedData) = existingResult,
            let protectedStoreData = protectedData.value,
            let protectedStore = NSKeyedUnarchiver.unarchiveObject(with: protectedStoreData) as? [String: Any] {
            store = protectedStore
        }
    }

    func set(_ value: Any?, forKey key: String, securely _: Bool = true, persisted _: Bool = true) throws {
        var storeCopy = store
        storeCopy[key] = value
        let object = KeychainObject(account: kProtectedDataAccount, value: NSKeyedArchiver.archivedData(withRootObject: storeCopy))
        try celyKeychain.set(query: object)
        store[key] = value
    }

    func clearStorage() throws {
        try celyKeychain.delete(query: KeychainObject())
        store = [:]
    }

    func get(_ key: String) -> Any? {
        return store[key]
    }
}
