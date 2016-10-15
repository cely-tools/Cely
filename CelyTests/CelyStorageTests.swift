//
//  CelyStorageTests.swift
//  Cely
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely

struct Dummy {

    var key: String!
    var value: Any?
    var storeSecurely: Bool!

    func failedMessage(returnedValue: Any?) -> String {
        return "\(key!) failed! It's supposed to equal '\(value)'. Not '\(returnedValue)'."
    }
    func failedToSet() -> String {
        return "[\(key!), securely: \(storeSecurely!)]: failed to set in storage!"
    }

    // swiftlint:disable:next cyclomatic_complexity
    func test(value _value: Any?) -> Bool {
        if value == nil {
            return _value == nil
        }
        switch value {
        case let val as String:
            return val == _value as? String
        case let val as Float:
            return val == _value as? Float
        case let val as Double:
            return val == _value as? Double
        case let val as Int:
            return val == _value as? Int
        case let val as [String]:
            return val == (_value as? [String])!
        case let val as [Float]:
            guard let _vals = _value as? [Float] else { return false }
            return val.elementsEqual(_vals)
        case let val as [Double]:
            guard let _vals = _value as? [Double] else { return false }
            return val.elementsEqual(_vals)

        default:
            print("value = \(value), _value = \(_value)")
            return false
        }
    }
}

class CelyStorageTests: XCTestCase {

    var dummyData: [Dummy]!
    var store: CelyStorage!

    override func setUp() {
        super.setUp()

        store = CelyStorage.sharedInstance

        dummyData = [
            Dummy(key: "testString", value: "string success", storeSecurely: false),
            Dummy(key: "testString_secure", value: "string success", storeSecurely: true),
            Dummy(key: "testFloat", value: 1.058, storeSecurely: false),
            Dummy(key: "testFloat_secure", value: 1.058, storeSecurely: true),
            Dummy(key: "testInt", value: 100, storeSecurely: false),
            Dummy(key: "testInt_secure", value: 100, storeSecurely: true),
            Dummy(key: "testNil", value: nil, storeSecurely: false),
            Dummy(key: "testNil_secure", value: nil, storeSecurely: true),
            Dummy(key: "testArrayOfStrings", value: ["string1 success", "string2 success"], storeSecurely: false),
            Dummy(key: "testArrayOfStrings_secure", value: ["string1 success", "string2 success"], storeSecurely: true),
            Dummy(key: "testArrayOfNumbers", value: [50, 48.5, 895.5], storeSecurely: false),
            Dummy(key: "testArrayOfNumbers_secure", value: [50, 48.5, 895.5], storeSecurely: true)
        ]
    }

    override func tearDown() {
        dummyData = nil
        UserDefaults().removePersistentDomain(forName: kCelyDomain)
        super.tearDown()
    }

    func testSavingData() {
        dummyData.forEach { dummy in

            let success = store.set(dummy.value, forKey: dummy.key, securely: dummy.storeSecurely)
            if dummy.value != nil {
                XCTAssert(success, dummy.failedToSet())
            } else {
                XCTAssert(success == false, "You're not supposed to be able to set nil in the storage.")
            }
        }
    }

    func testGettingData() {
        testSavingData()
        dummyData.forEach { dummy in
            let data = store.get(dummy.key)
            XCTAssert(dummy.test(value: data), dummy.failedMessage(returnedValue: data))
        }

        let data = store.get("non-existing-value")
        XCTAssert(data == nil, "Data should've return as `nil`")
    }

    func testRemoveAllData() {
        testSavingData()
        var secureCount = store.secureStorage.count
        var storageCount = dummyData.flatMap({ dummy -> Any? in
            guard dummy.storeSecurely == false else { return nil }
            return store.get(dummy.key)
        }).count

        XCTAssert(secureCount == 5, "Did not add all entries inside of 'secureStorage'")
        XCTAssert(storageCount == 5, "Did not add all entries inside of 'storage'")

        store.removeAllData()

        secureCount = store.secureStorage.count
        storageCount = dummyData.flatMap({ dummy -> Any? in
            guard dummy.storeSecurely == false else { return nil }
            return store.get(dummy.key)
        }).count

        XCTAssert(secureCount == 0, "Did not remove all entries inside of 'secureStorage'")
        XCTAssert(storageCount == 0, "Did not remove all entries inside of 'storage'")
    }
}
