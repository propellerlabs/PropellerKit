//
//  PokemonDetail.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import JSONCodable
import PropellerKit
import PropellerNetwork

struct PokemonDetail {
    let name: String
    let abilityA: String
    let abilityB: String?
    let abilityC: String?
    let image: String
}

extension PokemonDetail: JSONDecodable {
    init(object: JSONObject) throws {
        do {
            let decoder = JSONDecoder(object: object)
            name = try decoder.decode("name")
            image = try decoder.decode("sprites.front_default")
            abilityA = try decoder.decode("abilities[0].ability.name")
            abilityB = try? decoder.decode("abilities[1].ability.name")
            abilityC = try? decoder.decode("abilities[2].ability.name")
        } catch {
            throw error
        }
    }
}

extension PokemonDetail {
    static func detailFrom(path: String) -> Resource<PokemonDetail> {
        print(path)
        return PokemonDetail.resource(configuration: WebConfig.pokemon.emptyPath,
                                      urlPath: path)
    }
}
