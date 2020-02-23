//
//  CelyStorageErrorTests.swift
//  CelyTests-iOS
//
//  Created by Fabian Buentello on 9/30/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

@testable import Cely
import XCTest

class CelyStorageErrorTests: XCTestCase {
    func testDescription() {}

    func testErrorCode() {
        let error = CelyStorageError(status: -4)
        XCTAssert(error.errorCode == -4, "Failed to return correct error code")
    }

    func testErrorUserInfo() {
        let error = CelyStorageError(status: -4)
        guard let userInfoDescription = error.errorUserInfo[NSLocalizedDescriptionKey] as? String else {
            XCTFail("Failed to return description from `errorUserInfo`")
            return
        }

        XCTAssert(userInfoDescription == CelyStorageError.unimplemented.description, "Failed to return correct description")
    }

    func testOSStatusValues() {
        CelyStorageError.allCases.forEach { currentCase in
            guard let userInfoDescription = currentCase.errorUserInfo[NSLocalizedDescriptionKey] as? String else {
                XCTFail("Failed to return description from `errorUserInfo`")
                return
            }
            XCTAssert(currentCase.description == userInfoDescription, "Failed to return correct description")
        }
    }

    func testInvalidOSStatusValue() {
        let error = CelyStorageError(status: -12345)
        XCTAssert(error.description == CelyStorageError.unexpectedError.description, "Failed to return correct description")
    }
}
