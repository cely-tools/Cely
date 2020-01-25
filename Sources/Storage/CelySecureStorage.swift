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
        do {
            let currentProtectedData = try celyKeychain.getProtectedData()
            store = currentProtectedData
        } catch let error as CelyStorageError {
            // Expect this error to happen if first keychain is empty :)
            Cely.debugPrint(str: error.description)
        } catch {
            Cely.debugPrint(str: error.localizedDescription)
        }
    }

    func set(_ value: Any?, forKey key: String, securely _: Bool = true, persisted _: Bool = true) throws {
        var storeCopy = store
        storeCopy[key] = value
        try celyKeychain.set(storeCopy)
        store[key] = value
    }

    func clearStorage() throws {
        try celyKeychain.clearKeychain()
        store = [:]
    }

    func get(_ key: String) -> Any? {
        return store[key]
    }
}
