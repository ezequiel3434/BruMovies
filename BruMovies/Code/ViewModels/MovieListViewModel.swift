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
    
    
    
    
}
