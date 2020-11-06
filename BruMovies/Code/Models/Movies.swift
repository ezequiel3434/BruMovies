//
//  Movies.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 01/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation


//MARK: - Movie Response

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct genresID: Decodable {
    let genres: [genre]
}

struct genre: Decodable {
    let id: Int
    let name: String
}

//MARK: - Moview
struct Movie: Decodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //MARK: - Model Attributes
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double
    let voteCount: Int
    let runtime: Double?
    let releaseDate: String?
    let genreIds: [Int]?
    let genres: [genre]?
    let credits: MovieCredit?
    
    
    
    
    
   
    
    
}

//struct MovieGenre: Decodable {
//    let name: String
//}

struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

