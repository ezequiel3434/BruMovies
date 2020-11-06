//
//  MovieSearchViewController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 02/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchTableView: UITableView!
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Variables
    
    override class func description() -> String {
        "MovieSearchViewController"
    }
    
    
    let defaultsManager = UserDefaultsManager()
    let networkManager = NetworkManager.shared
    let fileHandler = FileHandler()
    
    var searchViewModel: MovieSearchViewModel!
    
    // MARK:- lifeCycle for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(MovieSearchTableViewCell().asNib(), forCellReuseIdentifier: MovieSearchTableViewCell.description())
        
        self.searchViewModel = MovieSearchViewModel(handler: FileHandler(), networkManager: NetworkManager.shared, defaultsManager: UserDefaultsManager())
        
        self.searchViewModel.searchedTitles.bind { val in
            self.searchTableView.reloadData()
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchViewModel.getTitlesFromSearch(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchViewModel.removeSearchedTitles()
        
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieViewModels = self.searchViewModel.searchedTitles.value else { return 0 }
        return movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieSearchTableViewCell().rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.description()) as? MovieSearchTableViewCell {
            guard let movieViewModels = self.searchViewModel.searchedTitles.value else { return UITableViewCell()}
            cell.searchViewModel = searchViewModel
            cell.setupCell(viewModel: movieViewModels[indexPath.row])
            return cell
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieViewModel = self.searchViewModel.searchedTitles.value else { return }
        
        guard let movieDetailVC =  UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: MovieDetailViewController.description()) as? MovieDetailViewController else { return }
        let movViewModel = movieViewModel[indexPath.row]
        movViewModel.getColors()
        movieDetailVC.viewModel = movViewModel
        movieDetailVC.movieListViewModel = MovieListViewModel(defaultsManager: defaultsManager, networkManager: networkManager, handler: fileHandler)
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    
    
    
}
