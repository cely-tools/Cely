//
//  StorageTests.swift
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
    var persisted: Bool! = false

    init(key: String, value: Any?, storeSecurely: Bool, persisted: Bool = false) {
        self.key = key
        self.value = value
        self.storeSecurely = storeSecurely
        self.persisted = persisted
    }

    func failedMessage(returnedValue: Any?) -> String {
        return "\(key!) failed! It's supposed to equal '\(String(describing: value))'. Not '\(String(describing: returnedValue))'."
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
            if let _val = _value as? [String] {
                return val == _val
            }
            return false
        case let val as [Float]:
            guard let _vals = _value as? [Float] else { return false }
            return val.elementsEqual(_vals)
        case let val as [Double]:
            guard let _vals = _value as? [Double] else { return false }
            return val.elementsEqual(_vals)

        default:
            print("value = \(String(describing: value)), _value = \(String(describing: _value))")
            return false
        }
    }
}

class StorageTests: XCTestCase {

    var dummyData: [Dummy]!
    var store: CelyStorage!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.setPersistentDomain(["store": [:], "persisted": [:]], forName: kCelyDomain)
        UserDefaults.standard.synchronize()

        store = CelyStorage.sharedInstance

        dummyData = [
            Dummy(key: "testString", value: "string success", storeSecurely: false),
            Dummy(key: "testString", value: "string success", storeSecurely: false, persisted: true),
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
        UserDefaults.standard.setPersistentDomain(["store": [:], "persisted": [:]], forName: kCelyDomain)
        UserDefaults.standard.synchronize()
        super.tearDown()
    }
    
    func testSavingData() {
        dummyData.forEach { dummy in
            let success = store.set(dummy.value, forKey: dummy.key, securely: dummy.storeSecurely, persisted: dummy.persisted)
            if dummy.value != nil {
                let successStatus = success == StorageResult.success || success == StorageResult.fail(LocksmithError.duplicate)
                XCTAssert(successStatus, dummy.failedToSet())
            } else {
                XCTAssert(StorageResult.fail(.undefined) == success, "You're not supposed to be able to set nil in the storage.")
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
        #if swift(>=4.1)
        var storageCount = dummyData.compactMap({ dummy -> Any? in
            guard !dummy.storeSecurely, !dummy.persisted else { return nil }
            return store.get(dummy.key)
        }).count
        #else
        var storageCount = dummyData.flatMap({ dummy -> Any? in
        guard !dummy.storeSecurely, !dummy.persisted else { return nil }
        return store.get(dummy.key)
        }).count
        #endif


        XCTAssert(secureCount == 5, "Did not add all entries inside of 'secureStorage': \(secureCount)")
        XCTAssert(storageCount == 5, "Did not add all entries inside of 'storage': \(storageCount)")

        store.removeAllData()

        secureCount = store.secureStorage.count

        #if swift(>=4.1)
        storageCount = dummyData.compactMap({ dummy -> Any? in
            guard !dummy.storeSecurely, !dummy.persisted else { return nil }
            return store.get(dummy.key)
        }).count
        #else
        storageCount = dummyData.flatMap({ dummy -> Any? in
        guard !dummy.storeSecurely, !dummy.persisted else { return nil }
        return store.get(dummy.key)
        }).count
        #endif

        XCTAssert(secureCount == 0, "Did not remove all entries inside of 'secureStorage': \(secureCount)")
        XCTAssert(storageCount == 1, "Did not remove all entries inside of 'storage': \(storageCount)")
    }
}
