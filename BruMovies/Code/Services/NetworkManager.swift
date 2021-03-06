//
//  NetworkManager.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 01/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: MovieService {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let apiKey = "API KEY"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    private let fileHandler = FileHandler()
    private let imageCompressionScale: CGFloat = 1
    
    //MARK: - Genres Array
    
    
    
    func getGenresBy(id: Int) -> String? {
        
        let response: genresID? = try? Bundle.main.loadAndDecodeJSON(filename: "genres")
        let genresArray = response!.genres
        return genresArray.filter { (genre) -> Bool in
            genre.id == id
            }[0].name
        
        
    }
    
    //MARK: - Functions to call the API
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            
            completion(.failure(.invalidEndpoint))
            return
            
        }
        
        self.loadURLAndDecode(url: url, params: [
            "language": "es-ES",
            "include_adult": "false"
        ], completion: completion)
        
    }
    
    func downloadMovieImage(url: URL?,imageType: MovieListImage ,id: Int, completion: @escaping(URL?, MovieError?) -> ()) {
        
        guard let url = url else {
            
            completion(nil,.invalidEndpoint)
            return
            
        }
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            guard let imageData = data else {
                print("no data")
                return
            }
            
            
            guard let image = UIImage(data: imageData), let compressedData = image.jpegData(compressionQuality: self.imageCompressionScale) else { return }
            do {
                try compressedData.write(to: self.fileHandler.getPathForImage(id: id, imageType: imageType ))
                
                
                completion(self.fileHandler.getPathForImage(id: id, imageType: imageType), nil )
                
                
            } catch {
                print( "serialization error")
            }
        }.resume()
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "es-ES",
            "include_adult": "false",
            "query": query
        ], completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "es-ES",
            "include_adult": "false"
        ], completion: completion)
    }
    
    //MARK: - get favourites
    
    func getSubscribedMovies(ids: [Int], completion:@escaping ([Movie]?, MovieError?)->()) {
        var movies = [Movie]()
        let group = DispatchGroup()
        for i in 0..<ids.count {
            group.enter()
            fetchMovie(id: ids[i]) { (res) in
                switch res {
                    
                case .success(let movie):
                    movies.append(movie)
                    group.leave()
                case .failure(_):
                    print("Failed to fetch data of movie with id: \(ids[i])")
                }
            }
        }
        group.notify(queue: .main, execute: {
            completion(movies,nil)
        })
    }
    
    
    
    
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        //print(finalURL)
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            
            completion(result)
        }
    }
    
    
}

