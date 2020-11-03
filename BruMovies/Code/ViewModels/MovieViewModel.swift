//
//  MovieViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 03/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

/// The MovieViewModel consumes a movie model and provides the required data to be used by the viewControlers.
/// This viewModel is used by the cells and by the listViewModels for providing the data.
/// This is created for displaying movies anywhere in the app, you could call the api and intialize the model and use it to display all movie related data , thus removing any logical parts from VC.

struct MovieViewModel {
    
    //MARK: - variables
    let fileHandler: FileHandler
    let networkManager: NetworkManager
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
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
        
    //    var genreText: String {
    //        genres?.first?.name ?? "n/a"
    //    }
        
        var ratingText: String {
            let rating = Int(voteAverage)
            let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
                return acc + "★"
            }
            return ratingText
        }
        
        var scoreText: String {
            guard ratingText.count > 0 else {
                return "n/a"
            }
            return "\(ratingText.count)/10"
        }
        
        var yearText: String {
            guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else { return "n/a" }
            return MovieViewModel.yearFormatter.string(from: date)
        }
        
//        var durationText: String {
//            guard let runtime = self.runtime, runtime > 0 else {
//                return "n/a"
//            }
//            return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
//        }
        
//        var cast: [MovieCast]? {
//            credits?.cast
//        }
//        var crew: [MovieCrew]? {
//            credits?.crew
//        }
//
//        var directors: [MovieCrew]? {
//            crew?.filter{ $0.job.lowercased() == "director" }
//        }
//
//        var producers: [MovieCrew]? {
//            crew?.filter{ $0.job.lowercased() == "producer" }
//        }
//
//        var screenWriters: [MovieCrew]? {
//            crew?.filter{ $0.job.lowercased() == "story" }
//        }
//

}
