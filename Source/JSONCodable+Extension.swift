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

extension JSONDecodable {
    
    /// Parses `Any` into a `JSONCodable` object of Type
    public static func parseJsonType(json: Any) throws -> Self? {
        guard let json = json as? JSONObject else { return nil }

        do {
            return try Self(object: json)
        } catch {
            throw error
        }
    }
}

extension Collection where Iterator.Element: JSONDecodable {
    
    /// Parses `Any` into an array of `JSONCodable` objects of Type
    public static func parseJsonArrayType(json: Any) throws -> [Iterator.Element]? {
        guard let json = json as? [JSONObject] else { return nil }
        do {
            return try Array<Iterator.Element>(JSONArray: json)
        } catch {
            throw error
        }
    }
}
