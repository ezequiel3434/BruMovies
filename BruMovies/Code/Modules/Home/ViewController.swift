//
//  ViewController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 31/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager.shared
    var movieService: NetworkManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        movieService = NetworkManager.shared
        self.movieService!.fetchMovies(from: .topRated  ) { [weak self] (result) in
                   guard let self = self else { return }
                   
                   switch result {
                   case .success(let response):
                       print(response.results)
                       
                   case .failure(let error):
                       print(error)
                   }
               }
    }


}

