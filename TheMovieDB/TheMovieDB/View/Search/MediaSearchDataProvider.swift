//
//  MediaSearchDataProvider.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

protocol MediaSearchDataProvidable {
    func fetch(from endpoint: String, completion: @escaping (Result<MediaSearchList, NetworkError>) -> Void)
}

struct MediaSearchDataProvider: MediaSearchDataProvidable, APIDataProvidable {
    func fetch(from endpoint: String, completion: @escaping (Result<MediaSearchList, NetworkError>) -> Void) {
        guard var url = URL.tmdbBaseURL else {
            completion(.failure(.badURL(nil)))
            return
        }
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "d7a52eac01377fcd82bfa02d2b8bdc03")
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        let searchQueryItem = URLQueryItem(name: "query", value: endpoint)
        components.queryItems = [apiKeyQueryItem, searchQueryItem]
        
        guard let finalURL = components.url else { return }
    
        perform(URLRequest(url: finalURL)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let list = try decoder.decode(MediaSearchList.self, from: data)
                    completion(.success(list))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.requestError(error)))
            }
        }
    }
}
