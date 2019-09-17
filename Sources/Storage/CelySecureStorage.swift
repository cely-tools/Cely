//
//  CelySecureStorage.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 7/27/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

internal class CelySecureStorage {
    var store: [String : Any] = [:]
    private let _celyKeychain = CelyKeychain()
    
    init() {
        do {
            let credentials = try _celyKeychain.getCredentials()
            store = credentials
        } catch {
            print("Failed to retrieve store from keychain")
            print(error)
        }
    }
    
    @discardableResult func clearStorage() -> Result<Void, CelyStorageError> {
        let result = _celyKeychain.clearKeychain()
        if case .success = result {
            store = [:]
            return .success(())
        }
        return result
    }

    func set(_ value: Any, forKey key: String) -> Result<Void, CelyStorageError> {
        var storeCopy = store
        storeCopy[key] = value
        let result = _celyKeychain.set(storeCopy)
        switch result {
        case .success:
            store[key] = value
            return .success(())
        default:
            return result
        }
    }

    func get(_ key: String) -> Any? {
        return store[key]
    }
}
