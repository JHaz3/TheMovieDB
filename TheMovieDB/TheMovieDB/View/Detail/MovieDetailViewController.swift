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
        guard let object = viewModel.mediaObject else { return }
        self.navigationController?.navigationBar.tintColor = .white
        titleLabel.text = object.title
        let date = formatStringToDate(dateString: object.releaseDate)
        let formattedDate = formatDate(date: date)
        releaseDateLabel.text = formattedDate
        overviewLabel.text = object.overview
        
        if var posterURL = URL.tmdbImageBaseURL,
           let path = viewModel.mediaObject?.posterPath {
            posterURL.appendPathComponent(path)
            posterImageView.setImage(using: URLRequest(url: posterURL))
        }
    }
    
    func setViewModel(using id: Int) {
        self.viewModel = MovieDetailViewModel(id: id, delegate: self)
    }
    
    fileprivate func formatStringToDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let dateObj = formatter.date(from: dateString)
        return dateObj ?? Date()
    }
    
    fileprivate func formatDate(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MMM d, yyyy"
        return format.string(from: date)
    }
}
