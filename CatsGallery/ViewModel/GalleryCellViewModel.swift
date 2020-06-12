//
//  GalleryCellViewModel.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 11/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class GalleryCellViewModel {
    
    private var image: Image
    
    init(image: Image) {
        self.image = image
    }
    
    var url: URL? {
        image.link
    }
}
