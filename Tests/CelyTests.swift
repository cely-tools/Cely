//
//  CelyTests.swift
//  CelyTests
//
//  Created by Fabian Buentello on 10/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

@testable import Cely
import XCTest
class DummyUser: CelyUser {
    enum Property: CelyProperty {
        case Username = "username"
        case Token = "token"
        case Email = "email"
    }
}

class DummyStorage: CelyStorageProtocol {
    public var dummyStorage: [String: Any?] = [
        "username": "testUser",
        "token": "helloToken",
    ]

    static var successful_setCalls = 0
    static var successful_removeCalls = 0
    func set(_ value: Any?, forKey _: String, securely _: Bool = true, persisted _: Bool = false) -> Result<Void, CelyStorageError> {
        if value == nil { return .failure(.param) }
        DummyStorage.successful_setCalls += 1
        return .success(())
    }

    func get(_ key: String) -> Any? {
        return dummyStorage[key] ?? nil
    }

    func removeAllData() {
        DummyStorage.successful_removeCalls += 1
    }
}

/// Tests for Cely Framework
class CelyTests: XCTestCase {
    var _properties: [DummyUser.Property]!
    var raw_properties: [CelyProperty] {
        #if swift(>=4.1)
            return _properties.compactMap { "\($0.rawValue)" }
        #else
            return _properties.flatMap { "\($0.rawValue)" }
        #endif
    }

    var triggeredNotification: String!
    override func setUp() {
        super.setUp()
        triggeredNotification = ""
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setTriggeredNotification_LoggedIn),
                         name: NSNotification.Name(rawValue: CelyStatus.loggedIn.rawValue),
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(setTriggeredNotification_LoggedOut),
                         name: NSNotification.Name(rawValue: CelyStatus.loggedOut.rawValue),
                         object: nil)

        _properties = [.Username, .Token]
        Cely.setup(with: nil, forModel: DummyUser(), requiredProperties: _properties, withOptions: [
            .storage: DummyStorage(),
        ])
    }

    func setTriggeredNotification_LoggedIn() {
        triggeredNotification = CelyStatus.loggedIn.rawValue
    }

    func setTriggeredNotification_LoggedOut() {
        triggeredNotification = CelyStatus.loggedOut.rawValue
    }

    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        super.tearDown()
    }

    func testSetup() {
        #if swift(>=4.1)
            let testRequiredProperties: [String] = _properties.compactMap { "\($0.rawValue)" }
        #else
            let testRequiredProperties: [String] = _properties.flatMap { "\($0.rawValue)" }
        #endif

        XCTAssert(Cely.requiredProperties == testRequiredProperties, "Cely does not match the mock results")
    }

    func testCurrentLogin_LoggedIn_Status() {
        testSetup()

        let status = Cely.currentLoginStatus(fromStorage: DummyStorage())
        XCTAssert(status == .loggedIn, "User failed to have status of being .loggedIn")

        let statusWithParameters = Cely.currentLoginStatus(requiredProperties: [DummyUser.Property.Username.rawValue, DummyUser.Property.Token.rawValue], fromStorage: DummyStorage())
        XCTAssert(statusWithParameters == .loggedIn, "User failed to have status of being .loggedIn")

        let notParameters = Cely.currentLoginStatus(requiredProperties: [], fromStorage: DummyStorage())
        XCTAssert(notParameters == .loggedOut, "User failed to have status of being .loggedIn")
    }

    func testCurrentLogin_LoggedOut_Status() {
        testSetup()

        Cely.requiredProperties.append(DummyUser.Property.Email.rawValue)

        let status = Cely.currentLoginStatus(fromStorage: DummyStorage())
        XCTAssert(status == .loggedOut, "User failed to have status of being .loggedOut")

        let statusWithParameters = Cely.currentLoginStatus(requiredProperties: [DummyUser.Property.Email.rawValue], fromStorage: DummyStorage())

        XCTAssert(statusWithParameters == .loggedOut, "User failed to have status of being .loggedOut")
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
        do {
            try Cely.save(3, forKey: "number").get()
        } catch {
            XCTFail("failed to save Number")
        }

        do {
            try Cely.save("string", forKey: "string").get()
        } catch {
            XCTFail("failed to save string")
        }

        do {
            try Cely.save("token", forKey: "tokenString").get()
        } catch {
            XCTFail("failed to save tokenString")
        }

        XCTAssert(DummyStorage.successful_setCalls == 3, "`Cely.store` and `DummyStorage` are not consistent")
    }

    func testUserAction() {
        Cely.changeStatus(to: .loggedIn)
        XCTAssert(triggeredNotification == "CelyStatus.loggedIn.user", "The .loggedIn status didnt properly set 'triggeredNotification'")

        Cely.changeStatus(to: .loggedOut)
        XCTAssert(triggeredNotification == "CelyStatus.loggedOut.user", "The .loggedOut status didnt properly set 'triggeredNotification'")
    }

    func testIsUserLoggedIn() {
        XCTAssert(Cely.isLoggedIn(), "User should be logged in.")
    }

    func testLogOut() {
        Cely.logout()
        XCTAssert(DummyStorage.successful_removeCalls == 1, "Cely did not properly logout the user.")
    }
}
