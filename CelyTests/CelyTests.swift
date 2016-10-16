//
//  CelyTests.swift
//  CelyTests
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import XCTest
@testable import Cely
class DummyUser: CelyUser {
    enum Property: CelyProperty {
        case Username = "username"
        case Token = "token"
        case Email = "email"
    }
}

class DummyStorage: CelyStorage {

    public var dummyStorage: [String : Any?] = [
        "username":"testUser",
        "token":"helloToken"
    ]

    static var successful_setCalls = 0
    static var successful_removeCalls = 0
    override func set(_ value: Any?, forKey key: String, securely secure: Bool = true) -> StorageResult {
        if value == nil { return .Fail(.undefined) }
        DummyStorage.successful_setCalls += 1
        return .Success
    }

    override func get(_ key: String) -> Any? {
        return dummyStorage[key]
    }

    override func removeAllData() {
        DummyStorage.successful_removeCalls += 1
    }
}


/// Tests for Cely Framework
class CelyTests: XCTestCase {
    var _properties: [DummyUser.Property]!
    var raw_properties: [CelyProperty] {
        return _properties.flatMap({"\($0.rawValue)"})
    }
    var triggeredNotification: String!
    override func setUp() {
        super.setUp()
        triggeredNotification = ""
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setTriggeredNotification_LoggedIn),
                         name: NSNotification.Name(rawValue: CelyStatus.LoggedIn.rawValue),
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setTriggeredNotification_LoggedOut),
                         name: NSNotification.Name(rawValue: CelyStatus.LoggedOut.rawValue),
                         object: nil)

        _properties = [.Username, .Token]
        Cely.store = DummyStorage()
        Cely.setup(with: nil, forModel: DummyUser(), requiredProperties: _properties)
    }

    func setTriggeredNotification_LoggedIn() {
        triggeredNotification = CelyStatus.LoggedIn.rawValue
    }

    func setTriggeredNotification_LoggedOut() {
        triggeredNotification = CelyStatus.LoggedOut.rawValue
    }

    override func tearDown() {

        NotificationCenter.default.removeObserver(self)
        super.tearDown()
    }


    func testSetup() {
        let testRequiredProperties = _properties.flatMap({"\($0.rawValue)"})
        XCTAssert(Cely.requiredProperties == testRequiredProperties, "Cely does not match the mock results")
    }

    func testCurrentLogin_LoggedIn_Status() {
        testSetup()

        let status = Cely.currentLoginStatus(fromStorage:DummyStorage())
        XCTAssert(status == .LoggedIn, "User failed to have status of being .LoggedIn")

        let statusWithParameters = Cely.currentLoginStatus(requiredProperties: [DummyUser.Property.Username.rawValue, DummyUser.Property.Token.rawValue], fromStorage: DummyStorage())
        XCTAssert(statusWithParameters == .LoggedIn, "User failed to have status of being .LoggedIn")
    }

    func testCurrentLogin_LoggedOut_Status() {
        testSetup()

        Cely.requiredProperties.append(DummyUser.Property.Email.rawValue)

        let status = Cely.currentLoginStatus(fromStorage:DummyStorage())
        XCTAssert(status == .LoggedOut, "User failed to have status of being .LoggedOut")

        let statusWithParameters = Cely.currentLoginStatus(requiredProperties: [DummyUser.Property.Email.rawValue], fromStorage: DummyStorage())

        XCTAssert(statusWithParameters == .LoggedOut, "User failed to have status of being .LoggedOut")
    }

    func testGetProperty() {
        let testUsername = Cely.get(key: DummyUser.Property.Username.rawValue)

        XCTAssert(testUsername as? String == "testUser", "the username did not equal 'testUser'")

        let testToken = Cely.get(key: DummyUser.Property.Token.rawValue)

        XCTAssert(testToken as? String == "helloToken", "the token did not equal 'helloToken'")

        let testEmail = Cely.get(key: DummyUser.Property.Email.rawValue)

        XCTAssert(testEmail == nil, "the email did not equal 'nil'")
    }

    func testSaveProperty() {
        XCTAssert(Cely.save(3, forKey: "number") == StorageResult.Success, "failed to save Number")
        XCTAssert(Cely.save("string", forKey: "string") == StorageResult.Success, "failed to save string")
        XCTAssert(Cely.save(nil, forKey: "nilValue") == StorageResult.Fail(.undefined), "failed to save nilValue")
        XCTAssert(Cely.save("token", forKey: "tokenString") == StorageResult.Success, "failed to save tokenString")

        XCTAssert(DummyStorage.successful_setCalls == 3, "`Cely.store` and `DummyStorage` are not consistent")
    }

    func testUserAction() {
        Cely.changeStatus(to: .LoggedIn)
        XCTAssert(triggeredNotification == "CelyStatus.LoggedIn.user", "The .LoggedIn status didnt properly set 'triggeredNotification'")

        Cely.changeStatus(to: .LoggedOut)
        XCTAssert(triggeredNotification == "CelyStatus.LoggedOut.user", "The .LoggedOut status didnt properly set 'triggeredNotification'")
    }

    func testIsUserLoggedIn() {
        XCTAssert(Cely.isLoggedIn(), "User should be logged in.")
    }

    func testLogOut() {
        Cely.logout()
        XCTAssert(DummyStorage.successful_removeCalls == 1, "Cely did not properly logout the user.")
    }
}
