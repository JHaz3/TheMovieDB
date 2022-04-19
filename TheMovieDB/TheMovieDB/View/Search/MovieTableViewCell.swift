//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var id: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    func setConfiguration(with object: Movie) {
        self.id = object.id
        titleLabel.text = object.title
        releaseDateLabel.text = object.releaseDate
        overviewLabel.text = "\(object.rating)"
    }
}
