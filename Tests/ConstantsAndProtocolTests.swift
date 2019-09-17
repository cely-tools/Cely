//
//  ConstantsAndProtocolTests.swift
//  Cely
//
//  Created by Fabian Buentello on 11/5/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

@testable import Cely
import XCTest

struct DefaultStyleTest: CelyStyle {}

class ConstantsAndProtocolTests: XCTestCase {
    let testDummy = DefaultStyleTest()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}

// MARK: - Test Constants

extension ConstantsAndProtocolTests {
    func testLeftSpace_WithFrame() {
        let fakeTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        fakeTextField.leftSpacer = 20

        XCTAssertEqual(fakeTextField.leftSpacer, 20, "leftSpacer was supposed to return 20")
    }

    func testLeftSpace_WithoutFrame() {
        let fakeTextField = UITextField()
        fakeTextField.leftSpacer = 20
        fakeTextField.leftView = nil

        XCTAssertEqual(fakeTextField.leftSpacer, 0, "leftSpacer was supposed to return 0")
    }

    func testStorageResultEquatable() {
        let successResult = StorageResult.success
        let failureResult = StorageResult.fail(.undefined)

        XCTAssertNotEqual(successResult, failureResult, "Results were not supposed to be equal")
    }
}

// MARK: - Test Protocols

extension ConstantsAndProtocolTests {
    func testViewBackgroundColor() {
        XCTAssertEqual(testDummy.backgroundColor(), .white, "backgroundColor() was supposed to return .white")
    }

    func testTextFieldBackgroundColor() {
        XCTAssertEqual(testDummy.textFieldBackgroundColor(), .white, "textFieldBackgroundColor() was supposed to return .white")
    }

    func testButtonBackgroundColor() {
        XCTAssertEqual(testDummy.buttonBackgroundColor(), UIColor(red: 86 / 255, green: 203 / 255, blue: 249 / 255, alpha: 1), "buttonBackgroundColor() was supposed to return a light blue color")
    }

    func testButtonTextColor() {
        XCTAssertEqual(testDummy.buttonTextColor(), .white, "buttonTextColor() was supposed to return .white")
    }

    func testAppLogo() {
        XCTAssertEqual(testDummy.appLogo(), nil, "appLogo() was supposed to return nil")
    }
}
