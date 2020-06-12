//
//  GalleryViewModel.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 10/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class GalleryViewModel {
    
    private var images: [Image] = [] {
        didSet {
            imagesLoaded?()
        }
    }
    
    var imagesLoaded: (()->Void)?

    func loadImages(){
        ImgurAPI.getImages(onComplete: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let images):
                self.images = images.filter({($0.type?.contains("image"))!})
            case .failure:
                self.imagesLoaded?()
            }
        })
    }
    
    func count() -> Int {
        images.count
    }
    
    private func getImage(at indexPath: IndexPath) -> Image {
        return images[indexPath.row]
    }
    
    func cellViewModelFor(at indexPath: IndexPath) -> GalleryCellViewModel {
        let image = getImage(at: indexPath)
        return GalleryCellViewModel(image: image)
    }
}
