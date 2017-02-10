//
//  UIImageView+Extension.swift
//  PokemonList
//
//  Created by RGfox on 2/9/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageWith(url: URL) {
        print(url)
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Could not fetch image at \(url.absoluteString): \(error.localizedDescription)")
            }
            
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
