//
//  LoginStyles.swift
//  Cely
//
//  Created by Fabian Buentello on 11/4/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Cely
import UIKit

struct LoginStyles: CelyStyle {
    func appLogo() -> UIImage? {
        return UIImage(named: "Cely")
    }
}

struct CustomAnimator: CelyAnimator {
    func loginTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow) {
        guard let snapshot = celyWindow.snapshotView(afterScreenUpdates: true) else {
            return
        }

        destinationVC?.view.addSubview(snapshot)
        celyWindow.setCurrentViewController(to: destinationVC)

        UIView.animate(withDuration: 0.5, animations: {
            snapshot.transform = CGAffineTransform(translationX: 600.0, y: 0.0)
        }, completion: { (_: Bool) in
            snapshot.removeFromSuperview()
        })
    }

    func logoutTransition(to destinationVC: UIViewController?, with celyWindow: UIWindow) {
        guard let snapshot = celyWindow.snapshotView(afterScreenUpdates: true) else {
            return
        }

        destinationVC?.view.addSubview(snapshot)
        celyWindow.setCurrentViewController(to: destinationVC)

        UIView.animate(withDuration: 0.5, animations: {
            snapshot.transform = CGAffineTransform(translationX: -600.0, y: 0.0)
        }, completion: { (_: Bool) in
            snapshot.removeFromSuperview()
        })
    }
}
