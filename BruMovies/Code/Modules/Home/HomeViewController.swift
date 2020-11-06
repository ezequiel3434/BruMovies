//
//  ViewController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 31/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionsCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionsStackView: UIStackView!
    
    
    //MARK: - Variables
    override class func description() -> String {
        "HomeViewController"
    }
    
    var movieListViewModel: MovieListViewModel!
    
    let defaultsManager = UserDefaultsManager()
    let networkManager = NetworkManager.shared
    let fileHandler = FileHandler()
    
    
    var subcriptionsMoviesStackHeight: CGFloat = 0
    
    var visiblePaths: [IndexPath] = [IndexPath]()
//    let fileHandler = FileHandler()
//    let networkManager = NetworkManager.shared
//    var movieService: NetworkManager?
//    let id = "724989"
    
    //MARK: - LifeCycle methods for the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Now Playing
        self.setCollectionView(for: nowPlayingCollectionView, with: LargeTitleCollectionViewCell().asNib(), and: LargeTitleCollectionViewCell.description())
        // Top Rated
        self.setCollectionView(for: topRatedCollectionView, with: TitleCollectionViewCell().asNib(), and: TitleCollectionViewCell.description())
        // Subscribed movies
        self.setCollectionView(for: subscriptionsCollectionView, with: TitleCollectionViewCell().asNib(), and: TitleCollectionViewCell.description())
        
        self.movieListViewModel = MovieListViewModel(defaultsManager: defaultsManager, networkManager: networkManager, handler: fileHandler)

        self.subcriptionsMoviesStackHeight = self.subscriptionsStackView.frame.height
        
        self.movieListViewModel = MovieListViewModel(defaultsManager: defaultsManager, networkManager: networkManager, handler: fileHandler)
        
        /// bindings from the viewModels to update the View
        self.movieListViewModel.nowPlayingMovies.bind { (_) in
            self.nowPlayingCollectionView.reloadData()
            self.visiblePaths.removeAll()
        }
        
        self.movieListViewModel.topRatedMovies.bind { (_) in
            self.topRatedCollectionView.reloadData()
            self.visiblePaths.removeAll()
        }
        
        self.movieListViewModel.subscribedMovies.bind { movies in
        if let movies = movies {
            if (movies.isEmpty) {
                self.subscriptionsStackView.isHidden = true
            } else {
             
                self.subscriptionsStackView.isHidden = false
                self.subscriptionsCollectionView.reloadData()
            }
            }
            
        }
        
        self.movieListViewModel.noData.bind {
            guard let noDataType = $0 else { return }
            if (noDataType == .subscriptions) {
                self.subscriptionsStackView.isHidden = true
                
            }
        }
        
        
//        movieService = NetworkManager.shared
//        self.movieService!.fetchMovies(from: .nowPlaying  ) { (result) in
//
//
//                   switch result {
//                   case .success(let response ):
//                    let mov = response.results
//                    print(mov.map { String(describing: $0.id)  })
//
//                   case .failure(let error):
//                       print(error)
//                   }
//               }
        
//        self.movieService?.downloadMovieImage(urlString: "https://image.tmdb.org/t/p/w500/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg", id: "724989", completion: { res, error in
//        if (error == .none) {
//            print(self.fileHandler.getPathForImage(id: self.id).path)
//        }
//        })
        
//
//        self.movieService?.searchMovie(query: "batman", completion: { (result) in
//            switch result {
//            case .success(let response ):
//             let mov = response.results
//             print(mov)
//             print(mov.map { String(describing: $0.id)  })
//
//            case .failure(let error):
//                print(error)
//            }
//        })
        

        
//        let response: genresID? = try? Bundle.main.loadAndDecodeJSON(filename: "genres")
//       //print(response!.genres)
        //print(NetworkManager.shared.getGenresBy(id: 16)!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.movieListViewModel.getSubscribedMovies()
        
    }
    
    
    //MARK: - functions for the view controller
    
    func setCollectionView(for collectionView: UICollectionView, with nib: UINib, and identifier: String) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == nowPlayingCollectionView) {
            return self.movieListViewModel.getCountForDisplay(type: .nowPlaying)
        } else if (collectionView == topRatedCollectionView) {
            
            return self.movieListViewModel.getCountForDisplay(type: .topRated)
        } else {
            return self.movieListViewModel.getCountForDisplay(type: .subscriptions)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == nowPlayingCollectionView {
            guard let movieViewModels = movieListViewModel.nowPlayingMovies.value else { return UICollectionViewCell() }
            return movieListViewModel.prepareCellForDisplay(collectionView: collectionView, type: .nowPlaying, indexPath: indexPath, movieViewModel: movieViewModels[indexPath.row])
        } else if  collectionView == topRatedCollectionView {
            
            guard let movieViewModels = movieListViewModel.topRatedMovies.value else { return UICollectionViewCell() }
            
            return movieListViewModel.prepareCellForDisplay(collectionView: collectionView, type: .topRated, indexPath: indexPath, movieViewModel: movieViewModels[indexPath.row])
        } else {
            guard let movieViewModels = movieListViewModel.subscribedMovies.value else { return UICollectionViewCell() }
            return movieListViewModel.prepareCellForDisplay(collectionView: collectionView, type: .subscriptions, indexPath: indexPath, movieViewModel: movieViewModels[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == nowPlayingCollectionView {
            return collectionView.getSizeForHorizontalCollectionView(columns: 1, height: LargeTitleCollectionViewCell().cellHeight)
        } else {
            return collectionView.getSizeForHorizontalCollectionView(columns: 2.4, height: TitleCollectionViewCell().cellHeight)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieModel = MovieViewModel(meta: nil)
        if collectionView == nowPlayingCollectionView {
            guard let movieViewModels = movieListViewModel.nowPlayingMovies.value else { return }
            movieModel = movieViewModels[indexPath.item]
            //print(movieModel)
        } else if collectionView == topRatedCollectionView {
            guard let movieViewModels = movieListViewModel.topRatedMovies.value else { return }
            movieModel = movieViewModels[indexPath.item]
            //print(movieModel)
        } else {
            
            guard let movieViewModels = movieListViewModel.subscribedMovies.value else { return }
            
            movieModel = movieViewModels[indexPath.item]
        }
        guard let movieDetailVC = storyboard?.instantiateViewController(identifier: MovieDetailViewController.description()) as? MovieDetailViewController else { return }
        movieDetailVC.viewModel = movieModel
       
        movieDetailVC.movieListViewModel = self.movieListViewModel
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    
}
