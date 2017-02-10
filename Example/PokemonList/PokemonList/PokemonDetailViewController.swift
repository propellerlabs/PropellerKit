//
//  PokemonDetailViewController.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit
import PropellerKit
import PropellerNetwork

final class PokemonDetailViewController: UIViewController {
    

    @IBOutlet weak var pokeView: PokemonView!

    var requestPath = ""
    var detail: PokemonDetail? {
        didSet {
            populatePokeView()
        }
    }
    
    var layedOutSubviews = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !layedOutSubviews {
            layedOutSubviews = true
            fetchPokemonDetail()
        }
    }
    
    func populatePokeView() {
        guard let detail = detail else {
            return
        }
        pokeView.nameLabel.text = detail.name
        var ability = detail.abilityA
        if let abilityB = detail.abilityB {
            ability += "\n" + abilityB
        }
        if let abilityC = detail.abilityC {
            ability += "\n" + abilityC
        }
        pokeView.abilityLabel.text = ability
        if let path = URL(string: detail.image) {
            pokeView.pokemonImage.setImageWith(url: path)
        }
    }
    
    func fetchPokemonDetail() {
        WebService
        .request(PokemonDetail.detailFrom(path: requestPath))
        .complete { [weak self] detail in
            DispatchQueue.main.async {
                self?.detail = detail
            }
        }
        .failure { error in
            print(error.localizedDescription)
        }
    }
    
    
}
