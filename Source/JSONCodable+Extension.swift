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
    public static var parseJsonType: (Any) -> Self? {
        return {
            guard let json = $0 as? JSONObject else { return nil }
            return try? Self(object: json)
        }
    }
}

extension Collection where Iterator.Element: JSONDecodable {
    
    /// Parses `Any` into an array of `JSONCodable` objects of Type
    public static var parseJsonArrayType: (Any) -> [Iterator.Element]? {
        return {
            guard let json = $0 as? [JSONObject] else { return nil }
            return try? Array<Iterator.Element>(JSONArray: json)
        }
    }
}
