//
//  CelyProtocols.swift
//  Cely
//
//  Created by Fabian Buentello on 11/4/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

/// Protocol for model class to implements
public protocol CelyUser {
    /// Enum of all the properties you would like to save for a model
    associatedtype Property : RawRepresentable
}

/// Protocol a storage class must abide by in order for Cely to use it
public protocol CelyStorageProtocol {
    func set(_ value: Any?, forKey key: String, securely secure: Bool, persisted persist: Bool) -> StorageResult
    func get(_ key: String) -> Any?
    func removeAllData()
}

public protocol CelyStyle {
    func backgroundColor() -> UIColor
    func textFieldBackgroundColor() -> UIColor
    func buttonBackgroundColor() -> UIColor
    func buttonTextColor() -> UIColor
    func appLogo() -> UIImage?
}

public extension CelyStyle {

    func backgroundColor() -> UIColor {
        return .white
    }

    func textFieldBackgroundColor() -> UIColor {
        return .white
    }

    func buttonBackgroundColor() -> UIColor {
        return UIColor(red: 86/255, green: 203/255, blue: 249/255, alpha: 1)
    }

    func buttonTextColor() -> UIColor {
        return .white
    }

    func appLogo() -> UIImage? {
        return UIImage(named: "CelyLogo")
    }
}

struct DefaultSyle: CelyStyle {}
