//
//  User.model.swift
//  CelyExample
//
//  Created by Fabian Buentello on 9/27/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

import Cely

struct User: CelyUser {

    private init() {}
    static let ref = User()

    enum Property: CelyProperty {
        case Username = "username"
        case Email = "email"
        case Token = "token"

        func save(_ value: Any) {
            Cely.save(value, forKey: rawValue)
        }

        func get() -> Any? {
            return Cely.get(key: rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(value: Any, as property: Property) {
        property.save(value: value)
    }

    static func save(data: [Property : Any]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(property: Property) -> Any? {
        return property.get()
    }
}
