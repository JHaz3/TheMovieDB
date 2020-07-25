//
//  MovieController.swift
//  MovieDB
//
//  Created by Jake Haslam on 3/13/20.
//  Copyright © 2020 Jake Haslam. All rights reserved.
//

import UIKit

class MovieController {
    
    // MARK: -Properties
    static private let baseURL = URL(string: "https://api.themoviedb.org/3/")
    static private let apiValue = "2c5a9bac97f6aaa563a9200403bca4ed"
    static private let searchEndpoint = "search/movie"
    static private let apiKey = "api_key"
    static private let searchKey = "query"
    static private let posterEndPoint = URL(string: "https://image.tmdb.org/t/p/w500")
    
    static func fetchMovie(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let searchURL = baseURL.appendingPathComponent(searchEndpoint)
        
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: searchKey, value: searchTerm),
            URLQueryItem(name: apiKey, value: apiValue)
        ]
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.noData))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelobject.self, from: data)
                completion(.success(topLevelObject.results))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchPoster(for movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        guard let unwrappedMovie = movie.poster ?? nil else { return }
        let posterURL = posterEndPoint?.appendingPathComponent(unwrappedMovie)
        guard let posterImage = posterURL else { return completion(.failure(.noData)) }
        
        URLSession.shared.dataTask(with: posterImage) { data, _, error in
            if let error = error {
                return completion(.failure(.thrown(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else {
                return completion(.failure(.noData))
            }
            completion(.success(image))
        }.resume()
    }
}
