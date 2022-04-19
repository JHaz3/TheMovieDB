//
//  MediaSearchViewModel.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import Foundation

protocol MediaSearchViewModelDelegate: AnyObject {
    func searchResultsLoadedSuccessfully()
    func encountered(_ error: Error)
}

class MediaSearchViewModel {
    
    var searchObjects: [Movie] = []
    let dataProvider: MediaSearchDataProvidable
    weak var delegate: MediaSearchViewModelDelegate?
    
    init(dataProvider: MediaSearchDataProvidable = MediaSearchDataProvider(), delegate: MediaSearchViewModelDelegate) {
        self.dataProvider = dataProvider
        self.delegate = delegate
    }
    
    func search(searchTerm: String) {
        dataProvider.fetch(from: searchTerm) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                /// Assign the source of truth
                self.searchObjects = list.results
                /// Tell the viewController to reload the views
                self.delegate?.searchResultsLoadedSuccessfully()
            case .failure(let error):
                print("\(error.localizedDescription)")
                self.delegate?.encountered(error)
            }
        }
    }
}
