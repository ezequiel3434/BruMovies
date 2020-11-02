//
//  MovieService.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 01/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

protocol MovieService {
    func fetchMovies()
    func fetchMovie()
    func searchMovie()
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    
    var description: String {
        switch self {
        
        case .nowPlaying: return "Now Playing"
        case .topRated: return "Top Rated"
        }
    }
}


enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
