//
//  MovieTableViewController.swift
//  MovieDB
//
//  Created by Jake Haslam on 3/13/20.
//  Copyright © 2020 Jake Haslam. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        tableView.rowHeight = 150
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
}// End of Class
extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovie(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(_):
                    print("No movies found")
                }
            }
        }
    }
}
