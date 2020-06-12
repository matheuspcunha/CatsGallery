//
//  ImageCache.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 12/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class ImageCache {
    
    // MARK: - Properties
    
    private static let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Methods
    
    static func getImage(with url: URL, onComplete: @escaping (UIImage?) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            onComplete(image)
        } else {
            load(with: url, onComplete: onComplete)
        }
    }
    
    private static func load(with url: URL, onComplete: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            var image: UIImage?
            
            if let data = data {
                image = UIImage(data: data)
            }
        
            if let image = image {
                cache.setObject(image, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                onComplete(image)
            }
        }
        task.resume()
    }
}
