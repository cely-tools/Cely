//
//  CelyConstants.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

/// `String` type alias. Is used in User model
public typealias CelyProperty = String

/// `String` type alias. Command for cely to execute
public typealias CelyCommands = String

/// Statuses for Cely to perform actions on
public enum CelyStatus: CelyCommands {
    case loggedIn = "CelyStatus.loggedIn.user"
    case loggedOut = "CelyStatus.loggedOut.user"
}

/// Options that you can pass into Cely on `Cely.setup(_:)`
public enum CelyOptions {
    case storage
    case homeStoryboard
    case loginStoryboard
    case loginCompletionBlock
    case loginStyle
    case celyAnimator
}

// enum result on whether or not Cely successfully saved your data
public enum StorageResult: Equatable {
    case success
    case fail(LocksmithError)
}

public func == (lhs: StorageResult, rhs: StorageResult) -> Bool {
    switch (lhs, rhs) {
    case (let .fail(error1), let .fail(error2)):
        return error1 == error2

    case (.success, .success):
        return true

    default:
        return false
    }
}

internal extension UITextField {

    @IBInspectable var leftSpacer: CGFloat {
        get {
            if let l = leftView {
                return l.frame.size.width
            }
            return 0
        } set {
            leftViewMode = .always
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
        }
    }
}

public extension Dictionary {
    init(withoutOptionalValues initial: Dictionary<Key, Value?>) {
        self = [Key: Value]()
        for pair in initial {
            if pair.1 != nil {
                self[pair.0] = pair.1!
            }
        }
    }

    init(initial: Dictionary<Key, Value>, toMerge: Dictionary<Key, Value>) {
        self = Dictionary<Key, Value>()

        for pair in initial {
            self[pair.0] = pair.1
        }

        for pair in toMerge {
            self[pair.0] = pair.1
        }
    }
}

public extension UIWindow {
    func setCurrentViewController(to viewController: UIViewController?) {
        let previousViewController = rootViewController
        rootViewController = viewController

        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false)
        }
    }
}
