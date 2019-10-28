//
//  CelyCredentialStoreTests.swift
//  CelyTests-iOS
//
//  Created by Fabian Buentello on 9/29/19.
//  Copyright © 2019 ChaiOne. All rights reserved.
//

@testable import Cely
import XCTest

func == (lhs: KeychainObject, rhs: KeychainObject) -> Bool {
    return lhs.account == rhs.account && lhs.server == rhs.server
}

class MockKeychainStore: KeychainProtocol {
    var mockStore: [KeychainObject] = []

    func get(query: KeychainObject) -> Result<KeychainObject, Error> {
        let foundResult = mockStore.first { $0 == query }

        guard let item = foundResult else {
            return .failure(CelyStorageError.itemNotFound)
        }

        return .success(KeychainObject(account: item.account, server: item.server, value: item.value))
    }

    func set(query: KeychainObject) throws {
        mockStore.append(query)
    }

    func delete(query: KeychainObject) throws {
        mockStore.removeAll { $0 == query }
    }
}

class CelyCredentialStoreTests: XCTestCase {
    func testSettingGettingCredentials() {
        let store = CelyCredentialStore(keychain: MockKeychainStore())
        let result = store.set(username: "valid-username", password: "valid-password", server: "someserver.com")
        if case let .failure(error) = result {
            XCTFail("Failed to store credentials in store: \(error)")
        }

        let foundResult = store.get()

        switch foundResult {
        case let .success(creds):
            XCTAssert(creds.password == "valid-password", "Failed to retrieve password: \(creds.password)")
            XCTAssert(creds.username == "valid-username", "Failed to retrieve username: \(creds.username)")
            XCTAssert(creds.server == "someserver.com", "Failed to retrieve server: \(creds.server)")
        case let .failure(error):
            XCTFail("Failed to retrieve credentials: \(error)")
        }
    }

    func testUnsetCredentialsLookup() {
        try! Cely.store.set("some-fail-string", forKey: kCelyCredentialsLookupKey, securely: false, persisted: true)
        let store = CelyCredentialStore(keychain: MockKeychainStore())
        let result = store.get()
        guard case let .failure(error) = result else {
            return XCTFail("Should have received an error since credential lookup is not a dictionary")
        }

        print(error.localizedDescription)
        XCTAssert(error.localizedDescription == CelyStorageError.unexpectedError.description, "Should have received an `.unexpectedError`: \(error)")
    }

    func testMissingCredentialsLookup() {
        try! Cely.store.set([:], forKey: kCelyCredentialsLookupKey, securely: false, persisted: true)
        let store = CelyCredentialStore(keychain: MockKeychainStore())
        let result = store.get()
        guard case let .failure(error) = result else {
            return XCTFail("Should have received an error")
        }

        print(error.localizedDescription)
        XCTAssert(error.localizedDescription == CelyStorageError.itemNotFound.description, "Should have received an `.itemNotFound`: \(error)")
    }

    func testIncludesBiometrics() {
        let object = KeychainObject(account: "valid-username", server: "someserver.com", value: "valid-password".data(using: .utf8)!, accessibility: [.biometricsIfPossible])
        let getMap = object.toSetMap(withValue: false)
        let foundValue = getMap[kSecAttrAccessControl]
        XCTAssert(foundValue != nil, "Failed to find biometrics flag")
        let accessibility = object.getAccessibility()
        XCTAssert(accessibility == kSecAttrAccessibleWhenUnlocked, "Failed to set correct `accessibility`: \(accessibility)")
    }

    func testThisDeviceOnly() {
        let object = KeychainObject(account: "valid-username", server: "someserver.com", value: "valid-password".data(using: .utf8)!, accessibility: [.biometricsIfPossible, .thisDeviceOnly])
        let getMap = object.toSetMap(withValue: false)
        let foundValue = getMap[kSecAttrAccessControl]
        XCTAssert(foundValue != nil, "Failed to find biometrics flag")
        let accessibility = object.getAccessibility()
        XCTAssert(accessibility == kSecAttrAccessibleWhenUnlockedThisDeviceOnly, "Failed to set correct `accessibility`: \(accessibility)")
    }
}
