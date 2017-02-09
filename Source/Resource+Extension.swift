//
//  Resource+Extension.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/6/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import PropellerNetwork
import JSONCodable

extension JSONDecodable {
    
    /// Create a `Resource<A>` for a JSONCodable object passing in a default parse function to
    /// map resource response to a `JSONCodable` object of Type
    public static func resource(configuration: PropellerNetwork.WebServiceConfiguration,
                  urlPath: String,
                  method: PropellerNetwork.HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  headers: [String : String]? = nil,
                  encoding: ParameterEncoding = JSONEncoder.default) -> Resource<Self> {
        
        return Resource<Self>(configuration: configuration,
                        urlPath: urlPath, method: method,
                        parameters: parameters,
                        headers: headers,
                        encoding: encoding,
                        parsing: { object in
                            do {
                                return try Self.parseJsonType(json: object)
                            } catch {
                                throw error
                            }
                        }
        )
    }
}

extension Collection where Iterator.Element: JSONDecodable {
    
    /// Create a `Resource<A>` for a JSONCodable object passing in a default parse function to
    /// map resource response to an array of `JSONCodable` objects of Type
    public static func resource(configuration: PropellerNetwork.WebServiceConfiguration,
                  urlPath: String,
                  method: PropellerNetwork.HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  headers: [String : String]? = nil,
                  encoding: ParameterEncoding = JSONEncoder.default) -> Resource<[Self.Iterator.Element]> {
        
        return Resource<[Self.Iterator.Element]>(configuration: configuration,
                        urlPath: urlPath,
                        method: method,
                        parameters: parameters,
                        headers: headers,
                        encoding: encoding,
                        parsing: { object in
                            do {
                                return try Self.parseJsonArrayType(json: object)
                            } catch {
                                throw error
                            }
                        }
        )
    }
}
