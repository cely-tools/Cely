//
//  CelyLoginViewController.swift
//  Cely
//
//  Created by Fabian Buentello on 7/31/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

class CelyLoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet var textFields: [UITextField]?
    @IBOutlet fileprivate weak var bottomLayoutConstraint: NSLayoutConstraint!

    // MARK: - Variables
    var initialBottomConstant: CGFloat!

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField?.delegate = self
        passwordField?.delegate = self

        loginButton?.addTarget(self, action: #selector(didPressLogin), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpKeyboardNotification()
        initialBottomConstant = bottomLayoutConstraint.constant
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func didPressLogin() {
        if let username = usernameField?.text, let password = passwordField?.text {
            Cely.loginCompletionBlock?(username, password)
        }

        usernameField?.text = ""
        passwordField?.text = ""
    }
}

internal extension CelyLoginViewController {

    // MARK: - Private

    fileprivate func setUpKeyboardNotification() {
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)),
                                                name: .UIKeyboardWillChangeFrame, object: nil)
    }

    func keyboardNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!

        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let rawCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }

        let animationDuration = (duration).doubleValue
        let keyboardEndFrame = (endFrame).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (rawCurve).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))

        let newConstraint = view.bounds.maxY - convertedKeyboardEndFrame.minY
        bottomLayoutConstraint.constant = newConstraint == 0 ? initialBottomConstant : newConstraint

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: [.beginFromCurrentState, animationCurve],
                       animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension CelyLoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let next = textFields?.filter({$0.tag == nextTag}).first {
            next.becomeFirstResponder()
            return true
        }

        textField.resignFirstResponder()
        return true
    }
}
