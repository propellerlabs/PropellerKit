//
//  JSONCodable+Extension.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import XCTest
import PropellerNetwork

class JSONCodableExtension: XCTestCase {

    func testParseJSONCodable() {
        let userString = "{ \"name\": \"Roy\" }"
        
        guard let data = userString.data(using: .utf8) else {
            XCTFail("Could not create data from User json string")
            return
        }
        guard let json = try? JSONDecoder.decode(data) else {
            XCTFail("JSONDecoder could not create JSON from data")
            return
        }
        guard let userJson = json as? JSONObject else {
            XCTFail("Could not cast JSON object as JSONObject")
            return
        }
        
        var user: User?
        var parseError: Error?
        
        do {
            user = try User.parseJsonType(json: userJson as Any)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(user)
        XCTAssertNil(parseError)
        
        XCTAssert(user?.name == "Roy")
    }
    
    func testParseJSONCodableKeyPathParse() {
        let userString = "{ \"user\": { \"name\": \"Roy\" }}"
        
        guard let data = userString.data(using: .utf8) else {
            XCTFail("Could not create data from User json string")
            return
        }
        guard let json = try? JSONDecoder.decode(data) else {
            XCTFail("JSONDecoder could not create JSON from data")
            return
        }
        guard let userJson = json as? JSONObject else {
            XCTFail("Could not cast JSON object as JSONObject")
            return
        }
        
        var user: User?
        var parseError: Error?
        
        do {
            user = try User.parseJsonType(json: userJson as Any, keyPath: "user")
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(user)
        XCTAssertNil(parseError)
        
        XCTAssert(user?.name == "Roy")
    }
    
    func testParseJSONCodableArray() {
        let usersString = "[ { \"name\": \"Roy\" }, { \"name\": \"Rich\" } ]"
        
        guard let data = usersString.data(using: .utf8) else {
            XCTFail("Could not create data from User json string")
            return
        }
        guard let json = try? JSONDecoder.decode(data) else {
            XCTFail("JSONDecoder could not create JSON from data")
            return
        }
        guard let usersJson = json as? [JSONObject] else {
            XCTFail("Could not cast JSON object as JSONObject")
            return
        }
        
        var users: [User]?
        var parseError: Error?
        
        do {
            users = try [User].parseJsonArrayType(json: usersJson as Any)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(users)
        XCTAssertNil(parseError)
        XCTAssert(users?[1].name == "Rich")
    }
    
    func testParseJSONCodableArrayKeyPath() {
        let usersString = "{ \"users\": [ { \"name\": \"Roy\" }, { \"name\": \"Rich\" } ] }"
        
        guard let data = usersString.data(using: .utf8) else {
            XCTFail("Could not create data from User json string")
            return
        }
        guard let json = try? JSONDecoder.decode(data) else {
            XCTFail("JSONDecoder could not create JSON from data")
            return
        }
        
        var users: [User]?
        var parseError: Error?
        
        do {
            users = try [User].parseJsonArrayType(json: json, keyPath: "users")
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(users)
        XCTAssertNil(parseError)
        XCTAssert(users?[1].name == "Rich")
    }
    
    func testResourceJSONCodableRequest() {
        let expectation = self.expectation(description: "Request returns completion")
        
        let httpBinCreateUserResource = HTTPBin.createUser(name: "Roy")
        
        var requestError: Error?
        var requestUser: User?
        
        WebService.request(httpBinCreateUserResource) { httpBinObject, error in
            if let error = error {
                requestError = error
            }
            
            if let httpBinObject = httpBinObject {
                requestUser = httpBinObject.user
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNil(requestError)
        XCTAssertNotNil(requestUser)
    }
}
