//
//  PokemonView.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit
import PropellerKit

class PokemonView: UIView, ViewNibNestable {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        reuseView()
    }
    
}
