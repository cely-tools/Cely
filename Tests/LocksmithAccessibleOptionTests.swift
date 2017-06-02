//
//  LocksmithAccessibleOptionTests.swift
//  Cely
//
//  Created by Fabian Buentello on 3/22/17.
//  Copyright © 2017 Fabian Buentello. All rights reserved.
//

import XCTest
import Cely

class LocksmithAccessibleOptionTests: XCTestCase {

    func testKSecAttrAccessibleWhenUnlocked() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleWhenUnlocked))
        XCTAssert(option == .whenUnlocked, "kSecAttrAccessibleWhenUnlocked was supposed to equal '\(LocksmithAccessibleOption.whenUnlocked)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleAfterFirstUnlock() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleAfterFirstUnlock))
        XCTAssert(option == .afterFirstUnlock, "kSecAttrAccessibleAfterFirstUnlock was supposed to equal '\(LocksmithAccessibleOption.afterFirstUnlock)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleAlways() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleAlways))
        XCTAssert(option == .always, "kSecAttrAccessibleAlways was supposed to equal '\(LocksmithAccessibleOption.always)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleWhenUnlockedThisDeviceOnly() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly))
        XCTAssert(option == .whenUnlockedThisDeviceOnly, "kSecAttrAccessibleWhenUnlockedThisDeviceOnly was supposed to equal '\(LocksmithAccessibleOption.whenUnlockedThisDeviceOnly)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleAfterFirstUnlockThisDeviceOnly() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly))
        XCTAssert(option == .afterFirstUnlockThisDeviceOnly, "kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly was supposed to equal '\(LocksmithAccessibleOption.afterFirstUnlockThisDeviceOnly)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleAlwaysThisDeviceOnly() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleAlwaysThisDeviceOnly))
        XCTAssert(option == .alwaysThisDeviceOnly, "kSecAttrAccessibleAlwaysThisDeviceOnly was supposed to equal '\(LocksmithAccessibleOption.alwaysThisDeviceOnly)', not \(String(describing: option))")
    }
    func testKSecAttrAccessibleWhenPasscodeSetThisDeviceOnly() {
        let option = LocksmithAccessibleOption(rawValue: String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly))
        XCTAssert(option == .whenPasscodeSetThisDeviceOnly, "kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly was supposed to equal '\(LocksmithAccessibleOption.whenPasscodeSetThisDeviceOnly)', not \(String(describing: option))")
    }

    func testDefaultCase() {
        let option = LocksmithAccessibleOption(rawValue: "test")
        XCTAssert(option == .whenUnlocked, "kSecClassIdentity was supposed to equal '\(LocksmithAccessibleOption.whenUnlocked)', not \(String(describing: option))")
    }

}
