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

    @IBOutlet weak var appImageView: UIImageView?
    @IBOutlet weak var usernameField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet var textFields: [UITextField]?
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    // MARK: - Variables
    var initialBottomConstant: CGFloat!
    var styles: CelyStyle!

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField?.delegate = self
        passwordField?.delegate = self

        setupStyle()
        loginButton?.addTarget(self, action: #selector(didPressLogin), for: .touchUpInside)
    }

    private func setupStyle() {

        styles = CelyWindowManager.manager.loginStyle

        view.backgroundColor = styles.backgroundColor()
        loginButton?.setTitleColor(styles.buttonTextColor(), for: .normal)
        loginButton?.backgroundColor = styles.buttonBackgroundColor()
        textFields?.forEach({$0.backgroundColor = styles.textFieldBackgroundColor()})
        if let image = styles.appLogo() {
            appImageView?.image = image
        }
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

    @objc func didPressLogin() {
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

    func convertNotification(notification: NSNotification) -> (duration: Double, endFrame: CGRect, animationCurve: UIViewAnimationOptions)? {

        guard let userInfo = notification.userInfo,
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let rawCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uint32Value else { return nil }

        let rawAnimationCurve = rawCurve << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))

        return (duration, endFrame, animationCurve)
    }

    @objc func keyboardNotification(notification: NSNotification) {

        guard let (duration, endFrame, animationCurve) = convertNotification(notification: notification) else {
            return
        }

        let convertedKeyboardEndFrame = view.convert(endFrame, from: view.window)
        let newConstraint = view.bounds.maxY - convertedKeyboardEndFrame.minY
        bottomLayoutConstraint.constant = newConstraint == 0 ? initialBottomConstant : newConstraint

        UIView.animate(withDuration: duration,
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
