//
//  WebService+Extension.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/3/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import XCTest
@testable import PropellerKit
import PropellerNetwork

class WebServiceExtension: XCTestCase {
    
    func testNetworkRequestThenPromise() {
        let expectation = self.expectation(description: "Resource request returns promise and calls then")
        
        let getResource = Resource<Void>(configuration: NetworkConfiguration.default, urlPath: "/get")
        
        WebService.request(getResource)
            .complete { object in
                expectation.fulfill()
                XCTAssert(true)
            }
            .failure { error in
                XCTAssertNil(error)
            }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testNetworkRequestFailedPromise() {
        let expectation = self.expectation(description: "Resource request returns promise and calls failed")
        
        let getResource = Resource<Void>(configuration: NetworkConfiguration.default, urlPath: "/getssss")
        
        WebService.request(getResource)
            .complete { object in
                XCTAssertNil(object)
            }
            .failure { error in
                expectation.fulfill()
                XCTAssertNotNil(error)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

struct NetworkConfiguration {
    static let `default` = WebServiceConfiguration(basePath: "http://httpbin.org",
                                                   additionalHeaders: nil,
                                                   credential: nil)
}
