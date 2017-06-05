//
//  LocksmithErrorTests.swift
//  Cely
//
//  Created by Fabian Buentello on 3/22/17.
//  Copyright © 2017 Fabian Buentello. All rights reserved.
//

import XCTest
import Cely

class LocksmithErrorTests: XCTestCase {

    func testErrSecAllocate() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecAllocate))
        XCTAssert(statusCode == .allocate, "errSecAllocate was supposed to equal '\(LocksmithError.allocate)', not \(String(describing: statusCode))")
    }
    func testErrSecAuthFailed() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecAuthFailed))
        XCTAssert(statusCode == .authFailed, "errSecAuthFailed was supposed to equal '\(LocksmithError.authFailed)', not \(String(describing: statusCode))")
    }
    func testErrSecDecode() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecDecode))
        XCTAssert(statusCode == .decode, "errSecDecode was supposed to equal '\(LocksmithError.decode)', not \(String(describing: statusCode))")
    }
    func testErrSecDuplicateItem() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecDuplicateItem))
        XCTAssert(statusCode == .duplicate, "errSecDuplicateItem was supposed to equal '\(LocksmithError.duplicate)', not \(String(describing: statusCode))")
    }
    func testErrSecInteractionNotAllowed() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecInteractionNotAllowed))
        XCTAssert(statusCode == .interactionNotAllowed, "errSecInteractionNotAllowed was supposed to equal '\(LocksmithError.interactionNotAllowed)', not \(String(describing: statusCode))")
    }
    func testErrSecItemNotFound() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecItemNotFound))
        XCTAssert(statusCode == .notFound, "errSecItemNotFound was supposed to equal '\(LocksmithError.notFound)', not \(String(describing: statusCode))")
    }
    func testErrSecNotAvailable() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecNotAvailable))
        XCTAssert(statusCode == .notAvailable, "errSecNotAvailable was supposed to equal '\(LocksmithError.notAvailable)', not \(String(describing: statusCode))")
    }
    func testErrSecParam() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecParam))
        XCTAssert(statusCode == .param, "errSecParam was supposed to equal '\(LocksmithError.param)', not \(String(describing: statusCode))")
    }
    func testErrSecUnimplemented() {
        let statusCode = LocksmithError(fromStatusCode: Int(errSecUnimplemented))
        XCTAssert(statusCode == .unimplemented, "errSecUnimplemented was supposed to equal '\(LocksmithError.unimplemented)', not \(String(describing: statusCode))")
    }

    func testDefaultCase() {
        let option = LocksmithError(fromStatusCode: 2342)
        XCTAssert(option == nil, "option was supposed to equal 'nil', not \(String(describing: option))")
    }
}
