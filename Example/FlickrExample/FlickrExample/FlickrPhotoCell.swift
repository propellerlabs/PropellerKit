//
//  FlickrPhotoCell.swift
//  FlickrExample
//
//  Created by Roy McKenzie on 2/10/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
