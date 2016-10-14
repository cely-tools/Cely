//
//  CelyStorage.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import Locksmith

class CelyStorage {
    // MARK: - Variables
    static let sharedInstance = CelyStorage()

    private init(){}
    // Secure storage

    // Insecure storage


    static func removeAllData() {

    }

    static func set(_ value: Any?, forKey: String) {

    }

    static func get(_ key: String) -> Any? {
        return nil
    }
}
