//
//  Imgur.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 10/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct Imgur: Decodable {
    private(set) var data: [Gallery]
}

struct Gallery: Decodable {
    private(set) var images: [Image]?
}

struct Image: Decodable {
    private(set) var id: String?
    private(set) var link: URL?
    private(set) var type: String?
}
