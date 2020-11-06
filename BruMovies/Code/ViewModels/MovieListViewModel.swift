//
//  MovieListViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 03/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import UIKit

struct MovieListViewModel {
    enum ListType {
        case nowPlaying
        case topRated
        case subscriptions
        
//        var getOptionName: String {
//            switch self {
//
//            case .nowPlaying, .topRated:
//                return "No me interesa"
//
//            case .subscriptions:
//                return "Remover"
//            }
//        }
//
//        var symbol: String {
//            switch self {
//
//             case .nowPlaying, .topRated:
//                 return "slash.circle.fill"
//
//             case .subscriptions:
//                 return "trash.fill"
//             }
//        }
    }
    
    //MARK: - Variables for the view Model
    let defaultsManager: UserDefaultsManager
    let networkManager: NetworkManager
    let fileHandler: FileHandler
    
    var subscribedMovies: BoxBind<[MovieViewModel]?> = BoxBind([MovieViewModel](repeating: MovieViewModel(meta: nil), count: 10))
    var nowPlayingMovies: BoxBind<[MovieViewModel]?> = BoxBind([MovieViewModel](repeating: MovieViewModel(meta: nil), count: 10))
    //[MovieViewModel](repeating: MovieViewModel(meta: nil), count: 10)
    var topRatedMovies: BoxBind<[MovieViewModel]?> = BoxBind([MovieViewModel](repeating: MovieViewModel(meta: nil), count: 10))
    
//    var subscribedMoviesOffset: BoxBind<(Int,Int)> = BoxBind((0,10))
//    var nowPlayingMoviesOffset: BoxBind<(Int,Int)> = BoxBind((0,10))
    
    var noData: BoxBind<(ListType?)> = BoxBind(nil)
   // var updateCollection: BoxBind<(ListType,IndexPath)?> = BoxBind(nil)
    
    //MARK: - initializer for the viewModel
    init(defaultsManager: UserDefaultsManager, networkManager: NetworkManager, handler: FileHandler ) {
        self.defaultsManager = defaultsManager
        self.networkManager = networkManager
        self.fileHandler = handler
        
        fetchMovieLists(type: .nowPlaying)
        fetchMovieLists(type: .topRated)
        
        
    }
    
    //MARK: - functions for the viewModel
    func fetchMovieLists(type: ListType) {
        
        if (type == .nowPlaying) {
            
            networkManager.fetchMovies(from: .nowPlaying) { (result) in
                switch result {
                    
                case .success(let value):
                    self.nowPlayingMovies.value = value.results.map{MovieViewModel(meta: $0)}
                case .failure(let error):
                    print("Failed to fetch data: \(error.localizedDescription)")
                }
            }
            
            
        } else if (type == .topRated) {
            networkManager.fetchMovies(from: .topRated) { (result) in
                switch result{
                    
                case .success(let value):
                    self.topRatedMovies.value = value.results.map{MovieViewModel(meta: $0)}
                case .failure(let error):
                    print("Failed to fetch data: \(error.localizedDescription)")
                }
            }
        }
    
        
        
    }
    
}

/// Methods for fetching data, used by the viewControllers

extension MovieListViewModel {
    /// methods for displaying cell data
    func getCountForDisplay(type: ListType) -> Int {
        if (type == .nowPlaying) {
            guard let movieViewModels = self.nowPlayingMovies.value else { return 0 }
            return movieViewModels.count
        } else if (type == .topRated) {
            guard let movieViewModels = self.topRatedMovies.value else { return 0 }
            return movieViewModels.count
        } else {
            guard let movieViewModels = self.subscribedMovies.value else { return 0 }
            return movieViewModels.count
        }
    }
    
    func prepareCellForDisplay(collectionView: UICollectionView, type: ListType, indexPath: IndexPath, movieViewModel: MovieViewModel) -> UICollectionViewCell {
        if (type == .topRated || type == .subscriptions) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.description() , for: indexPath ) as? TitleCollectionViewCell {
                cell.setupCell(viewModel: movieViewModel)
                return cell
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeTitleCollectionViewCell.description(), for: indexPath) as? LargeTitleCollectionViewCell {
                cell.setupCell(viewModel: movieViewModel)
                return cell
            }
        }
        fatalError()
    }
    
    
    func getSubscribedMovies() {
        let subscribed = defaultsManager.getSubcriptionsList()

        if (subscribed.isEmpty) {
            self.noData.value = .subscriptions
            
        } else {
            self.noData.value = .none
            // If there's no change don't call the API
            if let subsArray = self.subscribedMovies.value {
                if (subsArray.count == subscribed.count && subscribed.count != 1) {
                    return
                } else {
                    
                    networkManager.getSubscribedMovies(ids: Array(subscribed), completion: { (res, error) in
                        
                        guard let titlesMetaData = res else { return }
                        self.subscribedMovies.value = titlesMetaData.map { MovieViewModel(meta: $0)}.sorted { $0.id < $1.id}
                    })
                }
            }
        }
    }
    
    
    
    
}
