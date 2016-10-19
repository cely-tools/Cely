//
//  CelyWindowManagerTest.swift
//  Cely
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely

class CelyWindowManagerTest: XCTestCase {

    let testWindow = UIWindow()
    let testHomeStoryboard = UIStoryboard()
    var testLoginStoryboard = UIStoryboard()

    override func setUp() {
        super.setUp()
        CelyWindowManager.setup(window: testWindow, withOptions: [
            .HomeStoryboard: testHomeStoryboard,
            .LoginStoryboard: testLoginStoryboard
        ])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSetup() {
        XCTAssert(CelyWindowManager.manager.window == testWindow, "did not properly set manager's window object")
    }

    func testMatchingLoginScreens() {
        CelyWindowManager.setLoginStoryboard(testLoginStoryboard)
        XCTAssert(CelyWindowManager.manager.loginStoryboard == testLoginStoryboard, "did not properly set manager's login storyboard")
    }

    func testMatchingHomeScreens() {
        CelyWindowManager.setHomeStoryboard(testHomeStoryboard)
        XCTAssert(CelyWindowManager.manager.homeStoryboard == testHomeStoryboard, "did not properly set manager's home storyboard")
    }

    func testShowScreen() {
        testMatchingHomeScreens()
        Cely.changeStatus(to: .LoggedIn)
        XCTAssert(CelyWindowManager.manager.window.rootViewController == testHomeStoryboard.instantiateInitialViewController(), "did not properly set manager's home storyboard")

        Cely.changeStatus(to: .LoggedOut)
        XCTAssert(CelyWindowManager.manager.window.rootViewController == testLoginStoryboard.instantiateInitialViewController(), "did not properly set manager's login storyboard")
    }
}
