//
//  CelySecureStorage.swift
//  Cely
//
//  Created by Fabian Buentello on 3/21/17.
//  Copyright © 2017 Fabian Buentello. All rights reserved.
//

import Foundation

public enum CelySecureStorageError {
    case undefined
}

struct CelySecureStorage {

    static func deleteDataForAccount(userAccount: String, inService: String) throws {

    }

    static func loadDataForAccount(userAccount: String, inService: String) -> [String : Any]? {
        return nil
    }

    static func saveData(data: [String : Any], forUserAccount: String, inService: String) throws {

    }

    static func updateData(data: [String : Any], forUserAccount: String, inService: String) throws {

    }
}
