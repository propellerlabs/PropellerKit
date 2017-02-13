//
//  ViewController.swift
//  FlickrExample
//
//  Created by Roy McKenzie on 2/10/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit
import PropellerNetwork
import PropellerController

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionController: GeneralCollectionController<FlickrPhotoCell, FlickrPhoto> = {
        return GeneralCollectionController<FlickrPhotoCell, FlickrPhoto>()
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionController()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search flickr"
        navigationItem.titleView = searchController.searchBar

    }
    
    func performSearch() {
        guard let query = searchController.searchBar.text, !query.characters.isEmpty else { return }

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        let searchResource = FlickrResult.search(query: query)
        WebService.request(searchResource)
            .complete { [weak self] result in
                DispatchQueue.main.async {
                    self?.collectionController.setDataSource(result.photos)
                    self?.collectionView.reloadData()
                }
            }
            .always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            .failure { error in
                print("Flickr search request failed: \(error.localizedDescription)")
        }
    }
    
    private func configureCollectionController() {
        collectionController.collectionView = collectionView
        
        collectionController.sizeForIndexPath = { [weak self] _ in
            guard let width = self?.collectionView.frame.width else { return .zero }
            let cellWidth = (width/2)-5
            return CGSize(width: cellWidth, height: 150)
        }

        collectionController.willDisplayCell = { cell, photo, _ in
            cell.backgroundColor = .red
            cell.imageView.setImageWith(photo.url)
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        perform(#selector(performSearch), with: nil, afterDelay: 0.5)
    }
}

extension UIImageView {
    
    func setImageWith(_ url: URL?) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}

