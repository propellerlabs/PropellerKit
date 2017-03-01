//
//  MasterViewController.swift
//  PokemonList
//
//  Created by RGfox on 2/8/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit
import PropellerKit
import PropellerNetwork

class PokemonListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedPath = ""

    lazy var tableController: TableController.PokemonControllerType = {
       return TableController.pokemonList(self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
        configureTableController()
    }

    func segueFor(data: Pokemon) {
        selectedPath = data.path
        segueToPokeDetail()
    }

    func configureTableController() {

        tableController
            .didSelectCell = { [weak self] _, data, _ in
            self?.segueFor(data: data)
        }
        tableController
            .ofCell(type: PokeShortCell.self)
            .didSelectCell = { [weak self] _, data, _ in
            self?.segueFor(data: data)
        }
    }

    func segueToPokeDetail() {
        performSegue(withIdentifier: "seguePokemonDetail", sender: self)
    }
    
    func fetchPokemon() {
        WebService
        .request(Pokemon.getList)
        .complete { [weak self] list in
            DispatchQueue.main.async {
                self?.tableController.setDataSource(list)
            }
        }
        .failure(WebServiceError.self) { error in
            print(error.localizedDescription)
            assert(false,"something terrible is wrong")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? PokemonDetailViewController else {
            return
        }
        dest.requestPath = selectedPath
    }
}
