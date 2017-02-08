//
//  ResourceConfiguration.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import PropellerNetwork

/// Network configuration for testing
struct ResourceConfiguration {
    
    //. Default successful configuration
    static var `default`: WebServiceConfiguration = {
        let additionalHeaders = ["Content-Type": "application/json"]
        var credential = WebServiceConfigurationCredential(authHeaderKey: "Authorization")
        credential.authAccessToken = "TestAccessToken"
        return WebServiceConfiguration(basePath: "https://httpbin.org",
                                       additionalHeaders: additionalHeaders,
                                       credential: credential)
    }()
}
