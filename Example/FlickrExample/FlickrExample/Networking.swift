//
//  Networking.swift
//  FlickrExample
//
//  Created by Roy McKenzie on 2/10/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import PropellerKit
import PropellerNetwork

private let FlickrAPIKey = "85e9e388e04041b773a11fc3bc36a7d7"

struct NetworkConfiguration {
    private static let credential = QueryStringRequestCredential(authKey: "api_key", authToken: FlickrAPIKey)
    static let `default` = WebServiceConfiguration(basePath: "https://www.flickr.com/services/rest/",
                                                   additionalHeaders: nil,
                                                   credential: credential)
}

