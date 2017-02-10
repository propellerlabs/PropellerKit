//
//  Pokemon.swift
//  PokemonList
//
//  Created by RGfox on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import PropellerKit
import PropellerNetwork
import JSONCodable

struct Pokemon {
    let name: String
    let path: String
}

extension Pokemon: JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        do {
            name = try decoder.decode("name")
            path = try decoder.decode("url")
        } catch {
            throw error
        }
    }
}

//Resources
extension Pokemon {
    static var getList: Resource<[Pokemon]> {
        return [Pokemon].resource(configuration: WebConfig.pokemon,
                                  urlPath: "pokemon",
                                  parseKeyPath: "results")
    }
}

