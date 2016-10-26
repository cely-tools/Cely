//
//  CelyConstants.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import Locksmith

/// `String` type alias. Is used in User model
public typealias CelyProperty = String

/// `String` type alias. Command for cely to execute
public typealias CelyCommands = String

/// Statuses for Cely to perform actions on
public enum CelyStatus: CelyCommands {
    case LoggedIn = "CelyStatus.LoggedIn.user"
    case LoggedOut = "CelyStatus.LoggedOut.user"
}

/// Protocol for model class to implements
public protocol CelyUser {
    /// Enum of all the properties you would like to save for a model
    associatedtype Property : RawRepresentable
}

// enum result on whether or not Cely successfully saved your data
public enum StorageResult: Equatable {
    case Success
    case Fail(LocksmithError)
}

public func == (lhs: StorageResult, rhs: StorageResult) -> Bool {
    switch (lhs, rhs) {
    case (let .Fail(error1), let .Fail(error2)):
        return error1 == error2

    case (.Success, .Success):
        return true

    default:
        return false
    }
}

/// Options that you can pass into Cely on `Cely.setup(_:)`
public enum CelyOptions {
    case Storage
    case HomeStoryboard
    case LoginStoryboard
    case LoginCompletionBlock
}

/// Protocol a storage class must abide by in order for Cely to use it
public protocol CelyStorageProtocol {
    func set(_ value: Any?, forKey key: String, securely secure: Bool, persisted: Bool) -> StorageResult
    func get(_ key: String) -> Any?
    func removeAllData()
}
