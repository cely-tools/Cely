//
//  LoginViewControllerTests.swift
//  Cely
//
//  Created by Fabian Buentello on 10/27/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely

struct DummyStyles: CelyStyle {
    func backgroundColor() -> UIColor {
        return .brown
    }
    func buttonTextColor() -> UIColor {
        return .black
    }
    func buttonBackgroundColor() -> UIColor {
        return .white
    }
    func textFieldBackgroundColor() -> UIColor {
        return .yellow
    }
    func appLogo() -> UIImage? {
        return UIImage(named: "ChaiOneLogo.png")
    }
}

class LoginViewControllerTests: XCTestCase {

    var loginVC: CelyLoginViewController!
    let testDummy = DummyStyles()

    override func setUp() {
        super.setUp()
        CelyWindowManager.manager.loginStyle = DummyStyles()
        loginVC = CelyLoginViewController()

        let usernameTextField = UITextField()
		let passwordTextField = UITextField()
		
		loginVC.usernameField = usernameTextField
        loginVC.usernameField?.tag = 0
        loginVC.passwordField = passwordTextField
        loginVC.passwordField?.tag = 1
        loginVC.textFields = [loginVC.usernameField!, loginVC.passwordField!]
        loginVC.viewDidLoad()
    }

    override func tearDown() {
        super.tearDown()
    }
}

// MARK: - Test View LifeCycle
extension LoginViewControllerTests {
    func testViewDidLoad() {
        loginVC.viewDidLoad()

        if let usernameField = loginVC.usernameField {
            XCTAssert(loginVC.textFieldShouldReturn(usernameField), "Failed to set delegate for usernameTextField")
        }

        if let passwordField = loginVC.passwordField {
            XCTAssert(loginVC.textFieldShouldReturn(passwordField), "Failed to set delegate for passwordTextField")
        }
    }

    func testViewDidAppear() {

        let constraint = NSLayoutConstraint()
        constraint.constant = 20
        loginVC.bottomLayoutConstraint = constraint
        loginVC.viewDidAppear(true)

        XCTAssertEqual(loginVC.initialBottomConstant, 20, "Failed to properly call viewDidAppear")
    }
}

// MARK: - Test IBOutlets
extension LoginViewControllerTests {

    func testDidPressLogin() {

        loginVC.usernameField?.text = "username"
        loginVC.passwordField?.text = "password"

        loginVC.didPressLogin()

        XCTAssert(loginVC.passwordField?.text == "", "failed to reset password field.")
        XCTAssert(loginVC.usernameField?.text == "", "failed to reset username field.")
    }

    func testTextFieldShouldReturn() {
        let usernameBoolVal = loginVC.textFieldShouldReturn(loginVC.usernameField!)

        XCTAssert(usernameBoolVal, "failed to return username textfield.")

        XCTAssert(!loginVC.usernameField!.isFirstResponder, "failed to set password field as first responder")

        let passwordBoolVal = loginVC.textFieldShouldReturn(loginVC.passwordField!)

        XCTAssert(passwordBoolVal, "failed to return password textfield.")

        XCTAssert(!loginVC.passwordField!.isFirstResponder, "failed to remove first responder on password field.")
    }
}

// MARK: - Test Styles
extension LoginViewControllerTests {

    func testViewBackgroundColor() {
        XCTAssertEqual(loginVC.styles.backgroundColor(), testDummy.backgroundColor(), "view.backgroundColor was not properly set")
    }

    func testTextFieldBackgroundColor() {
        XCTAssertEqual(loginVC.styles.textFieldBackgroundColor(), testDummy.textFieldBackgroundColor(), "textFields backgroundColor was not properly set")
    }

    func testButtonBackgroundColor() {
        XCTAssertEqual(loginVC.styles.buttonBackgroundColor(), testDummy.buttonBackgroundColor(), "loginButton.backgroundColor was not properly set")
    }

    func testButtonTextColor() {
        XCTAssertEqual(loginVC.styles.buttonTextColor(), testDummy.buttonTextColor(), "loginButton.titleColor was not properly set")
    }

    func testAppLogo() {
        XCTAssertEqual(loginVC.styles.appLogo(), testDummy.appLogo(), "appImageView was not properly set")
    }
}

// MARK: - Test Notifications
extension LoginViewControllerTests {

    func testConvertNotification_Failure() {
        let fakeUserInfo: [AnyHashable : Any] = [
            UIKeyboardAnimationDurationUserInfoKey : "FORCE FAIL",
            UIKeyboardFrameEndUserInfoKey : NSValue(cgRect: .zero),
            UIKeyboardAnimationCurveUserInfoKey : NSNumber(value: 30)
        ]

        let fakeNotification = NSNotification(name: .UIKeyboardWillChangeFrame, object: nil, userInfo: fakeUserInfo)

        let converted = loginVC.convertNotification(notification: fakeNotification)

        XCTAssertNil(converted, "convertNotification was supposed to return nil")
    }

    func testConvertNotification_Success() {

        let fakeUserInfo: [AnyHashable : Any] = [
            UIKeyboardAnimationDurationUserInfoKey : NSNumber(value: 20),
            UIKeyboardFrameEndUserInfoKey : NSValue(cgRect: .zero),
            UIKeyboardAnimationCurveUserInfoKey : NSNumber(value: 30)
        ]

        let fakeNotification = NSNotification(name: .UIKeyboardWillChangeFrame, object: nil, userInfo: fakeUserInfo)

        let converted = loginVC.convertNotification(notification: fakeNotification)

        XCTAssertEqual(converted?.duration, 20, "failed to set duration")
        XCTAssert(type(of: converted!.duration) == Double.self, "duration is not of type Double.")

        XCTAssertEqual(converted?.endFrame, .zero, "failed to set endFrame")
        XCTAssert(type(of: converted!.endFrame) == CGRect.self, "endFrame is not of type CGRect.")

        XCTAssertEqual(converted?.animationCurve, UIViewAnimationOptions(rawValue: UInt(30) << 16), "failed to set duration")
        XCTAssert(type(of: converted!.animationCurve) == UIViewAnimationOptions.self, "animationCurve is not of type UIViewAnimationOptions.")

        print(converted ?? "failed to convert")
    }

    func testKeyboardNotification_Success() {

        let constraint = NSLayoutConstraint()
        loginVC.bottomLayoutConstraint = constraint
        loginVC.bottomLayoutConstraint.constant = 20

        let fakeUserInfo: [AnyHashable : Any] = [
            UIKeyboardAnimationDurationUserInfoKey : NSNumber(value: 20),
            UIKeyboardFrameEndUserInfoKey : NSValue(cgRect: CGRect(x: 0, y: 200, width: 320, height: 500)),
            UIKeyboardAnimationCurveUserInfoKey : NSNumber(value: 30)
        ]

        let fakeNotification = NSNotification(name: .UIKeyboardWillChangeFrame, object: nil, userInfo: fakeUserInfo)

        loginVC.keyboardNotification(notification: fakeNotification)

        // I simply ran this and paused inside of `keyboardNotification` to find value
        let correctValue: CGFloat = loginVC.view.bounds.maxY - 200

        XCTAssertEqual(loginVC.bottomLayoutConstraint.constant, correctValue, "bottomLayoutConstraint is supposed to be \(correctValue)")
    }

    func testKeyboardNotification_Failure() {

        let constraint = NSLayoutConstraint()
        loginVC.bottomLayoutConstraint = constraint
        loginVC.bottomLayoutConstraint.constant = 20

        let fakeUserInfo: [AnyHashable : Any] = [
            UIKeyboardAnimationDurationUserInfoKey : "FORCE FAIL",
            UIKeyboardFrameEndUserInfoKey : NSValue(cgRect: CGRect(x: 0, y: 200, width: 320, height: 500)),
            UIKeyboardAnimationCurveUserInfoKey : NSNumber(value: 30)
        ]

        let fakeNotification = NSNotification(name: .UIKeyboardWillChangeFrame, object: nil, userInfo: fakeUserInfo)

        loginVC.keyboardNotification(notification: fakeNotification)

        let converted = loginVC.convertNotification(notification: fakeNotification)

        XCTAssertNil(converted, "convertNotification was supposed to return nil")
    }
}
