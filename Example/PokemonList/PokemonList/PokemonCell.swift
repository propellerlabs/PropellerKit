//
//  PokemonCell.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        urlLabel.text = ""
    }
}
