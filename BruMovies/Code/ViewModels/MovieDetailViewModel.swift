//
//  MovieDetailViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    
    //MARK: - variable for the viewModel
    let fileHandler: FileHandler
    let networkManager: NetworkManager
    let defaultsManager: UserDefaultsManager
    
    let movieId: Int
    
    var movieReleaseDate: BoxBind<String?> = BoxBind(nil)
    var moviePlot: BoxBind<String?> = BoxBind(nil)
    
    //MARK: - initializer for the viewModel
    init(movieId: Int, handler: FileHandler, networkManager: NetworkManager, defaultsManager: UserDefaultsManager ) {
        self.movieId = movieId
        self.fileHandler = handler
        self.networkManager = networkManager
        self.defaultsManager = defaultsManager
        
        getTitleDetails()
    }
    
    //MARK: - functions for the viewModel
    func getTitleDetails() {
        networkManager.fetchMovie(id: movieId) { (result) in
            switch result {
                
            case .success(let movie):
                print(movie)
                if let titlePlotText = movie.overview {
                     self.moviePlot.value = titlePlotText
                } else {
                    self.moviePlot.value = "El resumen no ha sido proporcionado. En breve actualizaremos"
                }
                
            case .failure(let error):
                print("Failed to fetch data: \(error.localizedDescription)")
            }
            
        }
    }
    
}
