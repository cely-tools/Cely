//
//  CelyWindowManagerTest.swift
//  Cely
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely

let kWindowManagerNotification = "CallDummyCelyWindowManagerObserver"

class DummyCelyWindowManager: CelyWindowManager {
    static var observerCount = 0

    func setupNotification() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(dummyMethod),
                         name: NSNotification.Name(rawValue: kWindowManagerNotification),
                         object: nil)
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil)
    }
    
    @objc func dummyMethod() {
        DummyCelyWindowManager.observerCount += 1
    }
}

class CelyWindowManagerTest: XCTestCase {

    let testWindow = UIWindow()
    let testHomeStoryboard = UIStoryboard()
    var testLoginStoryboard = UIStoryboard()

    override func setUp() {
        super.setUp()
        CelyWindowManager.setup(window: testWindow, withOptions: [
            .homeStoryboard: testHomeStoryboard,
            .loginStoryboard: testLoginStoryboard
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
        Cely.changeStatus(to: .loggedIn)
        XCTAssert(CelyWindowManager.manager.window.rootViewController == testHomeStoryboard.instantiateInitialViewController(), "did not properly set manager's home storyboard")

        Cely.changeStatus(to: .loggedOut)
        XCTAssert(CelyWindowManager.manager.window.rootViewController == testLoginStoryboard.instantiateInitialViewController(), "did not properly set manager's login storyboard")
    }
    
    func testNotificationRemoveObserver() {
        
        var windowManager: DummyCelyWindowManager? = DummyCelyWindowManager()
        windowManager?.setupNotification()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil) 
        XCTAssertEqual(DummyCelyWindowManager.observerCount, 1, "ObserverCount is supposed to 1, not \(DummyCelyWindowManager.observerCount)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil)
        XCTAssertEqual(DummyCelyWindowManager.observerCount, 2, "ObserverCount is supposed to 2, not \(DummyCelyWindowManager.observerCount)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil)
        XCTAssertEqual(DummyCelyWindowManager.observerCount, 3, "ObserverCount is supposed to 3, not \(DummyCelyWindowManager.observerCount)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil)
        XCTAssertEqual(DummyCelyWindowManager.observerCount, 4, "ObserverCount is supposed to 4, not \(DummyCelyWindowManager.observerCount)")
        windowManager = nil
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWindowManagerNotification), object: nil)
        XCTAssertEqual(DummyCelyWindowManager.observerCount, 4, "ObserverCount should still be 4 since we unsubscribed to the notification center")
    }
}
