//
//  APIDataProvidable.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

protocol APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            // TODO: - Handle response
            if let response = response as? HTTPURLResponse {
                dump(response)
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

extension URL {
    static let tmdbBaseURL = URL(string: "https://api.themoviedb.org/3")
    static let tmdbImageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
}
