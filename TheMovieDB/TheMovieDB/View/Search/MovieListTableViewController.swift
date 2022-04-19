//
//  MovieListTableViewController.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    @IBOutlet weak var mediaSearchBar: UISearchBar!
    
    var viewModel: MediaSearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Search"
        viewModel = MediaSearchViewModel(delegate: self)
        mediaSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let object = viewModel.searchObjects[indexPath.row]
        cell.setConfiguration(with: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell,
            let id = cell.id else { return }
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? MovieDetailViewController else { return }
        vc.setViewModel(using: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}// End of Class

extension MovieListTableViewController: MediaSearchViewModelDelegate {
    func searchResultsLoadedSuccessfully() {
            self.tableView.reloadData()
    }
    
    func encountered(_ error: Error) {
        print("ERROR Loading Search Results")
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else {
            print("No text entered.")
            return
        }
        
        viewModel.dataProvider.fetch(from: searchTerm) { [weak self] result in
            switch result {
            case .success(let cinema):
                self?.viewModel.searchObjects = cinema.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.mediaSearchBar.resignFirstResponder()
                }
            case .failure(let error):
                print("Their was an error!", error.errorDescription!)
            }
        }
    }
}
