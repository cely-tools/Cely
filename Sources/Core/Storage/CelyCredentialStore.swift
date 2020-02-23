//
//  CelyCredentialStore.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 9/28/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

public struct CelyCredentials {
    public let username: String
    public let password: String
    public let server: String
}

/// CelyCredentialStore - object that stores user credentials
public struct CelyCredentialStore {
    static let sharedInstance = CelyCredentialStore()

    let keychain: KeychainProtocol

    init(keychain: KeychainProtocol = CelyKeychain()) {
        self.keychain = keychain
    }

    func setCredentialsLookupKey(keyDictionary: [CFString: Any]) throws {
        try Cely.store.set(keyDictionary, forKey: kCelyCredentialsLookupKey, securely: false, persisted: true)
    }

    func getCredentialsLookupKey() -> [CFString: Any]? {
        return Cely.get(key: kCelyCredentialsLookupKey) as? [CFString: Any]
    }

    /// Set user credentials
    /// - Parameters:
    ///   - username: username for user
    ///   - password: password for user
    ///   - server: api uri for account
    ///   - options: Array of AccessControlOptions for credentials to be saved with
    @discardableResult
    public func set(username: String, password: String, server: String, options: [AccessControlOptions] = []) -> Result<Void, Error> {
        guard let passwordData = password.data(using: .utf8) else {
            return .failure(CelyStorageError.invalidValue)
        }

        do {
            let keychainQuery = KeychainObject(account: username, server: server, value: passwordData, options: options)
            try setCredentialsLookupKey(keyDictionary: keychainQuery.toLookupMap())
            try keychain.set(query: keychainQuery)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    /// Return credentials
    public func get() -> Result<CelyCredentials, Error> {
        guard let lookupQuery = getCredentialsLookupKey() else {
            return .failure(CelyStorageError.unexpectedError)
        }
        guard
            case let .success(item) = keychain.get(query: KeychainObject.buildFromKeychain(dictionary: lookupQuery as CFTypeRef)),
            let username = item.account,
            let server = item.server,
            let passwordData = item.value else {
            return .failure(CelyStorageError.itemNotFound)
        }

        guard let password = String(data: passwordData, encoding: .utf8) else {
            return .failure(CelyStorageError.invalidValue)
        }

        return .success(CelyCredentials(username: username, password: password, server: server))
    }
}
