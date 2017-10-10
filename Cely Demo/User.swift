//
//  User.swift
//  Cely
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import Cely

struct User: CelyUser {

    enum Property: CelyProperty {
        case username = "username"
        case email = "email"
        case token = "token"

        func securely() -> Bool {
            switch self {
            case .token:
                return true
            default:
                return false
            }
        }

        func persisted() -> Bool {
            switch self {
            case .username:
                return true
            default:
                return false
            }
        }

        func save(_ value: Any) {
            Cely.save(value, forKey: rawValue, securely: securely(), persisted: persisted())
        }

        func get() -> Any? {
            return Cely.get(key: rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(_ value: Any, as property: Property) {
		property.save(value)
    }

    static func save(_ data: [Property : Any]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(_ property: Property) -> Any? {
        return property.get()
    }
}
