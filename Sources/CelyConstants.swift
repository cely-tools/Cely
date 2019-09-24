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
    case homeViewController
    case loginViewController
    case loginCompletionBlock
    case loginStyle
    case celyAnimator
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

public extension UIWindow {
    func setCurrentViewController(to viewController: UIViewController?) {
        let previousViewController = rootViewController
        rootViewController = viewController

        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false)
        }
    }
}
