//
//  CelyExampleTests.swift
//  CelyExampleTests
//
//  Created by Fabian Buentello on 9/27/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import CelyExample

class CelyExampleTests: XCTestCase {
    var testUser: User!

    override func setUp() {
        super.setUp()
        testUser = User.ref
    }

    func testSaveUserData() {
        // Save user data
    }

    func testGetUserData() {
        // Get user data
    }

    func testUserLogin() {
        // User should Log in
    }

    func testUserLogOut() {
        // User should Log out
    }

    override func tearDown() {
        // here
        super.tearDown()
    }
}
