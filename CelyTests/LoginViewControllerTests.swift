//
//  LoginViewControllerTests.swift
//  Cely
//
//  Created by Fabian Buentello on 10/27/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely

class LoginViewControllerTests: XCTestCase {

    var loginVC: CelyLoginViewController!

    override func setUp() {
        super.setUp()

        loginVC = CelyLoginViewController()
        loginVC.usernameField = UITextField()
        loginVC.usernameField?.tag = 0
        loginVC.passwordField = UITextField()
        loginVC.passwordField?.tag = 1
        loginVC.textFields = [loginVC.usernameField!, loginVC.passwordField!]
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoad() {
        loginVC.viewDidLoad()

        if let usernameField = loginVC.usernameField {
            XCTAssert(loginVC.textFieldShouldReturn(usernameField), "Failed to set delegate for usernameTextField")
        }

        if let passwordField = loginVC.passwordField {
            XCTAssert(loginVC.textFieldShouldReturn(passwordField), "Failed to set delegate for passwordTextField")
        }
    }

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
