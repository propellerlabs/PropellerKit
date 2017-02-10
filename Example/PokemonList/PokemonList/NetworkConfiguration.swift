//
//  NetworkConfiguration.swift
//  PokemonList
//
//  Created by RGfox on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import PropellerKit
import PropellerNetwork

struct WebConfig {
    static let pokemon = WebServiceConfiguration(basePath: "http://pokeapi.co/api/v2/",
                                                 additionalHeaders: nil,
                                                 credential: nil)
}


extension WebServiceConfiguration {
    static let empty = WebServiceConfiguration(basePath: nil,
                                               additionalHeaders: nil,
                                               credential: nil)
    var emptyPath: WebServiceConfiguration {
        return WebServiceConfiguration(basePath: nil,
                                       additionalHeaders: self.additionalHeaders,
                                       credential: self.credential)
    }
}
