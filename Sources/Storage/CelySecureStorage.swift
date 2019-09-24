//
//  CelySecureStorage.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 7/27/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Foundation

internal class CelySecureStorage {
    var store: [String: Any] = [:]
    private let _celyKeychain = CelyKeychain()

    init() {
        do {
            let currentProtectedData = try _celyKeychain.getProtectedData()
            store = currentProtectedData
        } catch let error as CelyStorageError {
            // Expect this error to happen if first keychain is empty :)
            Cely.debugPrint(str: error.description)
        } catch {
            Cely.debugPrint(str: error.localizedDescription)
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
