//
//  CelyProtocols.swift
//  Cely
//
//  Created by Fabian Buentello on 11/4/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

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

/// Protocol that allows styles to be applied to Cely's default LoginViewController
public protocol CelyStyle {
    func backgroundColor() -> UIColor
    func textFieldBackgroundColor() -> UIColor
    func buttonBackgroundColor() -> UIColor
    func buttonTextColor() -> UIColor
    func appLogo() -> UIImage?
}

public extension CelyStyle {

    /// Background Color for default login screen
    ///
    /// - returns: UIColor
    func backgroundColor() -> UIColor {
        return .white
    }

    /// Background Color for textfields
    ///
    /// - returns: UIColor
    func textFieldBackgroundColor() -> UIColor {
        return .white
    }

    /// Background Color for login button
    ///
    /// - returns: UIColor
    func buttonBackgroundColor() -> UIColor {
        return UIColor(red: 86/255, green: 203/255, blue: 249/255, alpha: 1)
    }

    /// Text Color for login button
    ///
    /// - returns: UIColor
    func buttonTextColor() -> UIColor {
        return .white
    }

    /// App icon for default login screen
    ///
    /// - returns: UIImage?
    func appLogo() -> UIImage? {
        return UIImage(named: "CelyLogo")
    }
}

struct DefaultSyle: CelyStyle {}

/// Handles Animations between Home and Login ViewControllers
public protocol CelyAnimator {
    func loginTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow)
    func logoutTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow)
}

struct DefaultAnimator: CelyAnimator {
    func loginTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow) {
        if let snapshot = celyWindow.snapshotView(afterScreenUpdates: true) {
            destinationVC?.view.addSubview(snapshot)
            celyWindow.setCurrentViewController(to: destinationVC)


            UIView.animate(withDuration: 0.5, animations: {
                snapshot.transform = CGAffineTransform(translationX: 600.0, y: 0.0)
            }, completion: { (value: Bool) in
                snapshot.removeFromSuperview()
            })
        }
    }

    func logoutTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow) {
        if let snapshot = celyWindow.snapshotView(afterScreenUpdates: true) {
            destinationVC?.view.addSubview(snapshot)
            celyWindow.setCurrentViewController(to: destinationVC)


            UIView.animate(withDuration: 0.5, animations: {
                snapshot.transform = CGAffineTransform(translationX: -600.0, y: 0.0)
            }, completion: {(value: Bool) in
                snapshot.removeFromSuperview()
            })
        }
    }
}
