//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

protocol MovieDetailViewModelDelegate: AnyObject {
    func updateViews()
}

class MovieDetailViewModel: APIDataProvidable {
    var mediaObject: MovieDetails?
    let id: Int
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(id: Int, delegate: MovieDetailViewModelDelegate) {
        self.id = id
        self.delegate = delegate
    }
    
    func fetchDetails() {
        guard var url = URL.tmdbBaseURL else { return }
        url.appendPathComponent("movie")
        url.appendPathComponent("\(id)")
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "d7a52eac01377fcd82bfa02d2b8bdc03")
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        components.queryItems = [apiKeyQueryItem]
        
        perform(URLRequest(url: components.url!)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    self.mediaObject = try JSONDecoder().decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async { self.delegate?.updateViews() }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
