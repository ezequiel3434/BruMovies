//
//  MovieViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 03/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import UIKit
//import UIImageColors


struct MovieViewModel {
    
    //MARK: - variables
    let id: Int
    let title: String
    let fileHandler: FileHandler
    let networkManager: NetworkManager
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String?
    let overview: String?
    let genres: [Int]?
    let runtime: Double?
    let genreObj: [genre]?
    
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        if genres != nil {
            return networkManager.getGenresBy(id: genres!.first ?? 10751) ?? "n/a"
        } else {
            return "n/a"
        }
        
    }
    
    var ratingText: String {
        let rating = Int(voteAverage/2)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\((ratingText.count))/5"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else { return "n/a" }
        return MovieViewModel.yearFormatter.string(from: date)
    }
    
    var moviePosterImage: BoxBind<UIImage?> = BoxBind(nil)
    var movieBackDropImage: BoxBind<UIImage?> = BoxBind(nil)
    var isFavorite: BoxBind<Bool?> = BoxBind(nil)
    var colors: BoxBind<UIImageColors?> = BoxBind(nil)
    
    
            var durationText: String {
                
                guard let runtime = self.runtime, runtime > 0 else {
                    return "n/a"
                }
                return MovieViewModel.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
            }
    

    
    
    //MARK: - Initializer for the viewModel
    
    init(meta: Movie?, handler: FileHandler = FileHandler(), networkManager: NetworkManager = NetworkManager.shared) {
        guard let meta = meta else {
            
            self.id = 0
            self.title = ""
            self.backdropPath = ""
            self.posterPath = ""
            self.voteAverage = 0.0
            self.voteCount = 0
            self.genres = []
            self.releaseDate = ""
            self.fileHandler = handler
            self.networkManager = networkManager
            self.overview = ""
            self.runtime = 0.0
            self.genreObj = [genre]()
            return }
        
        self.id = meta.id
        self.title = meta.title
        self.backdropPath = meta.backdropPath
        self.posterPath = meta.posterPath
        self.voteAverage = meta.voteAverage
        self.voteCount = meta.voteCount
        self.genres = meta.genreIds
        self.releaseDate = meta.releaseDate
        self.fileHandler = handler
        self.networkManager = networkManager
        self.overview = meta.overview
        self.runtime = meta.runtime
        self.genreObj = meta.genres
        getMovieImage(imageType: .poster)
        getMovieImage(imageType: .backdrop)
       //getColors()
    }
    
    
    func getMovieImage(imageType: MovieListImage) {
        
        switch imageType {
            
        case .poster:
            if (fileHandler.checkIfFileExists(id: id, imageType: imageType)) {
                
                self.moviePosterImage.value = UIImage(contentsOfFile: fileHandler.getPathForImage(id: id, imageType: imageType).path)
                
            } else {
                networkManager.downloadMovieImage(url: self.posterURL, imageType: imageType, id: self.id) { res, error in
                    if (error == .none) {
                        self.moviePosterImage.value = UIImage(contentsOfFile: self.fileHandler.getPathForImage(id: self.id, imageType: imageType).path)
                        
                    }
                }
            }
        case .backdrop:
            if (fileHandler.checkIfFileExists(id: id, imageType: imageType)) {
                
                self.movieBackDropImage.value = UIImage(contentsOfFile: fileHandler.getPathForImage(id: id, imageType: imageType).path)
            } else {
                networkManager.downloadMovieImage(url: self.backdropURL, imageType: imageType, id: self.id) { res, error in
                    if (error == .none) {
                        self.movieBackDropImage.value = UIImage(contentsOfFile: self.fileHandler.getPathForImage(id: self.id, imageType: imageType).path)
                    }
                }
            }
        }
        
        
        
        
    }
    
    func getColors() {
        
        DispatchQueue.global().async {
            self.moviePosterImage.bind {
                guard let posterImage = $0 else { return }
                DispatchQueue.main.async {
                    
                    posterImage.getColors { colors in
                        self.colors.value = colors
                    }
                    
                }
                    
                    
                
            }
        }
        
        
        
    }
    
}
