//
//  ImgurAPI.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 10/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case taskError
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case invalidJSON
}

class ImgurAPI {
    
    // MARK: - Properties
    
    private static let path = "https://api.imgur.com/3/gallery/search/?q=cats"
    
    private static let header  = ["Authorization": "Client-ID 1ceddedc03a5d71" ]

    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    // MARK: - Methods
    
    private init() {}
    
    static func getImages(onComplete: @escaping (Result<[Image], APIError>) -> Void) {
        guard let url = URL(string: path) else {
            return onComplete(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                onComplete(.failure(.taskError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.invalidResponse))
            }
            
            if response.statusCode != 200 {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            do {
                let imgur = try JSONDecoder().decode(Imgur.self, from: data)
                var images: [Image] = []
                
                for data in imgur.data{
                    guard let image = data.images else {continue}
                    images.append(contentsOf: image)
                }
                
                onComplete(.success(images))
            } catch {
                onComplete(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
}
