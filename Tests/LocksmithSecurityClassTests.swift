//
//  LocksmithSecurityClassTests.swift
//  Cely
//
//  Created by Fabian Buentello on 3/22/17.
//  Copyright © 2017 Fabian Buentello. All rights reserved.
//

import XCTest
import Cely

class LocksmithSecurityClassTests: XCTestCase {

    func testKSecClassGenericPassword() {
        let securityClass = LocksmithSecurityClass(rawValue: String(kSecClassGenericPassword))
        XCTAssert(securityClass == .genericPassword, "kSecClassGenericPassword was supposed to equal '\(LocksmithSecurityClass.genericPassword)', not \(securityClass)")
    }

    func testKSecClassInternetPassword() {
        let securityClass = LocksmithSecurityClass(rawValue: String(kSecClassInternetPassword))
        XCTAssert(securityClass == .internetPassword, "kSecClassInternetPassword was supposed to equal '\(LocksmithSecurityClass.internetPassword)', not \(securityClass)")
    }

    func testKSecClassCertificate() {
        let securityClass = LocksmithSecurityClass(rawValue: String(kSecClassCertificate))
        XCTAssert(securityClass == .certificate, "kSecClassCertificate was supposed to equal '\(LocksmithSecurityClass.certificate)', not \(securityClass)")
    }

    func testKSecClassKey() {
        let securityClass = LocksmithSecurityClass(rawValue: String(kSecClassKey))
        XCTAssert(securityClass == .key, "kSecClassKey was supposed to equal '\(LocksmithSecurityClass.key)', not \(securityClass)")
    }

    func testKSecClassIdentity() {
        let securityClass = LocksmithSecurityClass(rawValue: String(kSecClassIdentity))
        XCTAssert(securityClass == .identity, "kSecClassIdentity was supposed to equal '\(LocksmithSecurityClass.identity)', not \(securityClass)")
    }

    func testDefaultCase() {
        let securityClass = LocksmithSecurityClass(rawValue: "test")
        XCTAssert(securityClass == .genericPassword, "kSecClassIdentity was supposed to equal '\(LocksmithSecurityClass.genericPassword)', not \(securityClass)")
    }

}
