//
//  JSONCodable+Extension.swift
//  PropellerKit
//
//  Created by Roy McKenzie on 2/6/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import Foundation
import JSONCodable
import PropellerNetwork

/// Error set for when there is an error parsing `JSONObject`
public enum JSONParseError: Error {
    /// Could not cast object to `JSONObject`
    case jsonObjectUncastable
}

extension JSONDecodable {
    
    /// Parses `Any` into a `JSONCodable` object of Type `A`
    /// - Parameters:
    ///     - json: JSON object to parse
    ///     - keyPath: An optional `String` representing the keyPath to the desired JSON object to decode.
    /// - Returns: `A`
    public static func parseJsonType(json: Any, keyPath: String? = nil) throws -> Self? {
        guard let json = json as? JSONObject else {
            throw JSONParseError.jsonObjectUncastable
        }

        var jsonObject: JSONObject = json

        if let keyPath = keyPath {
            let decoder = JSONDecoder(object: json)
            do {
                jsonObject = try decoder.decode(keyPath,
                                                transformer: JSONTransformers.JSONObjectType)
            } catch {
                throw error
            }
        }
        
        do {
            return try Self(object: jsonObject)
        } catch {
            throw error
        }
    }
}

extension Collection where Iterator.Element: JSONDecodable {
    
    /// Parses `Any` into an array of `JSONCodable` objects of Type `A`
    /// - Parameters:
    ///     - json: JSON object to parse
    ///     - keyPath: An optional `String` representing the keyPath to the desired JSON object to decode.
    /// - Returns: `A`
    public static func parseJsonArrayType(json: Any, keyPath: String? = nil) throws -> [Iterator.Element]? {

        // We are assuming that this is not a top level array if there is a keyPath provided
        if let keyPath = keyPath {
            guard let json = json as? JSONObject else {
                throw JSONParseError.jsonObjectUncastable
            }
            
            let decoder = JSONDecoder(object: json)
            do {
                let object: [JSONObject] = try decoder.decode(keyPath,
                                                              transformer: JSONTransformers.JSONObjectArray)
                
                return try Array<Iterator.Element>(JSONArray: object)
            } catch {
                throw error
            }
        }

        // Default implementation if no keyPath is provided
        guard let json = json as? [JSONObject] else { return nil }
        do {
            return try Array<Iterator.Element>(JSONArray: json)
        } catch {
            throw error
        }
    }
}

extension JSONTransformers {
    
    static let JSONObjectType = JSONTransformer<JSONObject,JSONObject>(
        decoding: { $0 },
        encoding: { $0 })
    
    static let JSONObjectArray = JSONTransformer<[JSONObject],[JSONObject]>(
        decoding: { $0 },
        encoding: { $0 })
}
