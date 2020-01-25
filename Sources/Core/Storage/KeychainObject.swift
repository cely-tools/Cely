//
//  KeychainObject.swift
//  Cely-iOS
//
//  Created by Fabian Buentello on 9/30/19.
//  Copyright © 2019 ChaiOne. All rights reserved.
//

import Foundation

typealias RawDictionary = AnyObject

struct KeychainObject {
    var baseQuery: [CFString: Any] = [
        kSecClass: kSecClassInternetPassword,
        kSecAttrLabel: kCelySecureStoreLabel,
    ]

    let account: String?
    let server: String?
    let value: Data?
    private let accessibilityOptions: [AccessibilityOptions]

    init(account: String? = nil, server: String? = nil, value: Data? = nil, accessibility: [AccessibilityOptions] = []) {
        self.account = account
        self.server = server
        self.value = value
        accessibilityOptions = accessibility
    }

    static func buildFromKeychain(dictionary: RawDictionary) -> KeychainObject {
        return KeychainObject(
            account: dictionary[kSecAttrAccount] as? String,
            server: dictionary[kSecAttrServer] as? String,
            value: dictionary[kSecValueData] as? Data
        )
    }

    func toLookupMap() -> [CFString: Any] {
        var lookupMap: [CFString: Any] = [:]

        if let account = account {
            lookupMap[kSecAttrAccount] = account
        }

        if let server = server {
            lookupMap[kSecAttrServer] = server
        }

        return baseQuery.merging(lookupMap) { _, new in new }
    }

    func toGetMap() -> [CFString: Any] {
        let limitQuery: [CFString: Any] = [
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true,
        ]

        let query = toLookupMap()
        return query.merging(limitQuery) { _, new in new }
    }

    func getAccessibility() -> CFString {
        let isThisDeviceOnly = accessibilityOptions.contains(.thisDeviceOnly)
        return isThisDeviceOnly ? kSecAttrAccessibleWhenUnlockedThisDeviceOnly : kSecAttrAccessibleWhenUnlocked
    }

    func toSetMap(withValue: Bool) -> [CFString: Any] {
        var userMap = toLookupMap()

        if let value = value, withValue {
            userMap[kSecValueData] = value
        }

        if accessibilityOptions.contains(.biometricsIfPossible) {
            // TODO: what happens if application doesnt have biometrics setup? does it error
            let accessibility = getAccessibility()
            var error: Unmanaged<CFError>?
            let access = SecAccessControlCreateWithFlags(nil,
                                                         accessibility,
                                                         .userPresence,
                                                         &error)

            userMap[kSecAttrAccessControl] = access
        }

        return baseQuery.merging(userMap) { _, new in new }
    }
}
