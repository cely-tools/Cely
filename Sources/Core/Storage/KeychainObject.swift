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
    private let accessControlOptions: [AccessControlOptions]

    init(account: String? = nil, server: String? = nil, value: Data? = nil, options: [AccessControlOptions] = []) {
        self.account = account
        self.server = server
        self.value = value
        accessControlOptions = options
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

    func getAccessControlOptions() -> CFString {
        let isThisDeviceOnly = accessControlOptions.contains(.thisDeviceOnly)
        return isThisDeviceOnly ? kSecAttrAccessibleWhenUnlockedThisDeviceOnly : kSecAttrAccessibleWhenUnlocked
    }

    func toSetMap(withValue: Bool) -> [CFString: Any] {
        var userMap = toLookupMap()

        if let value = value, withValue {
            userMap[kSecValueData] = value
        }

        if accessControlOptions.contains(.biometricsIfPossible) {
            let options = getAccessControlOptions()
            var error: Unmanaged<CFError>?
            let access = SecAccessControlCreateWithFlags(nil,
                                                         options,
                                                         .userPresence,
                                                         &error)

            userMap[kSecAttrAccessControl] = access
        }

        return baseQuery.merging(userMap) { _, new in new }
    }
}
