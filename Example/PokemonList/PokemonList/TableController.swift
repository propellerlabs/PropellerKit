//
//  TableController.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import PropellerController



struct TableController {
    
    typealias PokemonControllerType = GeneralTableController<PokemonCell, Pokemon>
    
    static var pokemonList: (UITableView) -> PokemonControllerType = { table in
        let controller = PokemonControllerType(cellTypeOption: .xibAuto,
                                               customIdentifier: "PokemonCell")        
        controller.tableView = table
        
        controller.willDisplayCell = { cell, data, _ in
            if cell.isSelected {
                cell.nameLabel.text = "Selected: " + data.name
            } else {
                cell.nameLabel.text = data.name
            }
            
            cell.urlLabel.text = data.path
        }
        
        controller.didSelectCell = { cell, data, _ in
            cell.nameLabel.text = "Selected: " + data.name
        }
        
        controller.didDeselectCell = { cell, data, _ in
            cell.nameLabel.text = data.name
        }
        
        return controller
    }
    
}
