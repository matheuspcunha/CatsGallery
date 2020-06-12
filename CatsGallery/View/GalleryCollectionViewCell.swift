//
//  GalleryCollectionViewCell.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 11/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    
    private let placeholder: UIImage = UIImage(named: "placeholder")!
    
    func configure(with viewModel: GalleryCellViewModel) {
        self.catImage.image = placeholder
        self.catImage.layer.cornerRadius = 8
        
        ImageCache.getImage(with: viewModel.url!) { [weak self] (image) in
            guard let self = self else {return}
            if let image = image {
                self.catImage.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        self.catImage.image = placeholder
    }
}
