//
//  HTTPBin.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import JSONCodable
import PropellerNetwork

struct HTTPBin {
    let user: User
}

extension HTTPBin {
    
    public static func createUser(name: String) -> Resource<HTTPBin> {
        let params = [
            "name": name
        ]
        return HTTPBin.resource(configuration: ResourceConfiguration.default,
                                        urlPath: "/post",
                                        method: .post,
                                        parameters: params)
    }
}

extension HTTPBin: JSONCodable {
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        self.user = try decoder.decode("json")
    }
}

struct User {
    let name: String
}

extension User: JSONCodable {
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        self.name = try decoder.decode("name")
    }
}

