//
//  MovieListViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 03/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct MovieListViewModel {
    enum ListType {
        case nowPlaying
        case topRated
        case subscriptions
        
        var getOptionName: String {
            switch self {
           
            case .nowPlaying, .topRated:
                return "No me interesa"
           
            case .subscriptions:
                return "Remover"
            }
        }
        
        var symbol: String {
            switch self {
            
             case .nowPlaying, .topRated:
                 return "slash.circle.fill"
            
             case .subscriptions:
                 return "trash.fill"
             }
        }
    }
    
    //MARK: - Variables for the view Model
    let defaultsManager: UserDefaultsManager
    let networkManager: NetworkManager
    let fileHandler: FileHandler
    
    var subscribedMovies: BoxBind<[MovieViewModel]?> = BoxBind(nil)
    var nowPlayingMovies: BoxBind<[MovieViewModel]?> = BoxBind(nil)
    //[MovieViewModel](repeating: MovieViewModel(meta: nil), count: 10)
    var topRatedMovies: BoxBind<[MovieViewModel]?> = BoxBind(nil)
    
//    var subscribedMoviesOffset: BoxBind<(Int,Int)> = BoxBind((0,10))
//    var nowPlayingMoviesOffset: BoxBind<(Int,Int)> = BoxBind((0,10))
    
   // var noData: BoxBind<(ListType?)> = BoxBind(nil)
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
