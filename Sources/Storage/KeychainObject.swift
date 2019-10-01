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
    let account: String?
    let server: String?
    let value: Data?

    init(account: String? = nil, server: String? = nil, value: Data? = nil) {
        self.account = account
        self.server = server
        self.value = value
    }

    static func buildFromKeychain(dictionary: RawDictionary) -> KeychainObject {
        return KeychainObject(
            account: dictionary[kSecAttrAccount] as? String,
            server: dictionary[kSecAttrServer] as? String,
            value: dictionary[kSecValueData] as? Data
        )
    }

    func toCFDictionary(withValue: Bool) -> [CFString: Any] {
        var query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrLabel: kCelySecureStoreLabel,
        ]

        if let account = account {
            query[kSecAttrAccount] = account
        }

        if let server = server {
            query[kSecAttrServer] = server
        }

        if let value = value, withValue {
            query[kSecValueData] = value
        }

        return query
    }
}
