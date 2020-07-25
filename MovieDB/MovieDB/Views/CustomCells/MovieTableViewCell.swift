//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Jake Haslam on 3/14/20.
//  Copyright © 2020 Jake Haslam. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie? {
        
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            ratingLabel.text = "\(movie.rating)"
            overviewLabel.text = movie.overview
            
            MovieController.fetchPoster(for: movie) { (result) in
                switch result {
                case .success(let poster):
                    DispatchQueue.main.async {
                        self.moviePoster.image = poster
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}// End of Class
