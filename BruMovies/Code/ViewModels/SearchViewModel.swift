//
//  SearchViewModel.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 06/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct MovieSearchViewModel {
    
    // MARK:- variable for the viewModel
    let fileHandler: FileHandler
    let networkManager: NetworkManager
    let defaultsManager: UserDefaultsManager
    
    var searchedTitles:  BoxBind<[MovieViewModel]?> = BoxBind(nil)
    var debounceTimer: BoxBind<Timer?> = BoxBind(nil)
    
    // MARK:- initializer for the viewModel
    init(handler:FileHandler, networkManager: NetworkManager, defaultsManager: UserDefaultsManager) {
        self.fileHandler = handler
        self.networkManager = networkManager
        self.defaultsManager = defaultsManager
    }
    
    // MARK:- functions for the viewModel
    func getTitlesFromSearch(query: String) {
        debounceTimer.value?.invalidate()
        debounceTimer.value =  Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            print("query", query)
            self.searchedTitles.value = [MovieViewModel](repeating: MovieViewModel(meta: nil), count: 5)
            self.networkManager.searchMovie(query: query, completion: { (res) in
                switch res {
                    
                case .success(let value):
                    self.searchedTitles.value = value.results.map { MovieViewModel(meta: $0)}
                case .failure(let error):
                    print("Search error: \(error.localizedDescription)")
                }
            })

        }
    }
    
    func removeSearchedTitles() {
        self.searchedTitles.value = nil
    }
}

extension MovieSearchViewModel: Likeable {
    var subscribedType: Subscriptions {
        .subscribedMovies
    }
    
    func subscribePressed(id: Int) -> Bool {
        let buttonStatus = defaultsManager.toggleSubcriptions(id: id)
        if (buttonStatus) {
            return true
        } else {
            return false
        }
    }
    
    func checkIfSubscribed(id: Int) -> Bool {
        if (defaultsManager.checkIfSubcription(id: id)) {
            return true
        } else  {
            return false
        }
    }
    
    
 
    
   
}
