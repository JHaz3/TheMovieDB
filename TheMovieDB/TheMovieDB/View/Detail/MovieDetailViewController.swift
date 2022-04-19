//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: AsyncImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDetails()
    }

    func updateViews() {
        self.navigationController?.navigationBar.tintColor = .white
        titleLabel.text = viewModel.mediaObject?.title
        releaseDateLabel.text = viewModel.mediaObject?.releaseDate
        overviewLabel.text = viewModel.mediaObject?.overview
        
        if var posterURL = URL.tmdbImageBaseURL,
           let path = viewModel.mediaObject?.posterPath {
            posterURL.appendPathComponent(path)
            posterImageView.setImage(using: URLRequest(url: posterURL))
        }
    }
    
    func setViewModel(using id: Int) {
        self.viewModel = MovieDetailViewModel(id: id, delegate: self)
    }
}
