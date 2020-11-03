//
//  ViewController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 31/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionsCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionsStackView: UIStackView!
    
    
    //MARK: - Variables
    override class func description() -> String {
        "HomeViewController"
    }
    
    
    
    
    
    
//    let fileHandler = FileHandler()
//    let networkManager = NetworkManager.shared
//    var movieService: NetworkManager?
//    let id = "724989"
    override func viewDidLoad() {
        super.viewDidLoad()
//        movieService = NetworkManager.shared
//        self.movieService!.fetchMovies(from: .nowPlaying  ) { (result) in
//
//
//                   switch result {
//                   case .success(let response ):
//                    let mov = response.results
//                    print(mov.map { String(describing: $0.id)  })
//
//                   case .failure(let error):
//                       print(error)
//                   }
//               }
        
//        self.movieService?.downloadMovieImage(urlString: "https://image.tmdb.org/t/p/w500/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg", id: "724989", completion: { res, error in
//        if (error == .none) {
//            print(self.fileHandler.getPathForImage(id: self.id).path)
//        }
//        })
        
//
//        self.movieService?.searchMovie(query: "batman", completion: { (result) in
//            switch result {
//            case .success(let response ):
//             let mov = response.results
//             print(mov)
//             print(mov.map { String(describing: $0.id)  })
//
//            case .failure(let error):
//                print(error)
//            }
//        })
        

        
//        let response: genresID? = try? Bundle.main.loadAndDecodeJSON(filename: "genres")
//       //print(response!.genres)
       
    }
    

    


}

