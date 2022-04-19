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
        let date = formatStringToDate(dateString: object.releaseDate)
        let dateString = formatDate(date: date)
        releaseDateLabel.text = dateString
        overviewLabel.text = "\(object.rating)"
    }
    
    func formatStringToDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let dateObj = formatter.date(from: dateString)
        return dateObj ?? Date() 
    }
    
    func formatDate(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MMM d, yyyy"
        return format.string(from: date)
    }
}
