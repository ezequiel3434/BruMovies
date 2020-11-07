//
//  BruMoviesTests.swift
//  BruMoviesTests
//
//  Created by Ezequiel Parada Beltran on 07/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import XCTest
@testable import BruMovies

class BruMoviesTests: XCTestCase {
    
    let handler = FileHandler()
    let networkManager = NetworkManager.shared
    let defaultsManager = UserDefaultsManager()
    
    var movieListVM: MovieListViewModel  {
        return MovieListViewModel(defaultsManager: UserDefaultsManager(), networkManager: NetworkManager.shared, handler: FileHandler())
    }

    // MovieListViewModel Tests
    func testNowPlayingTitlesFetch() {
        movieListVM.nowPlayingMovies.bind {
            guard let movieTitles = $0 else { return }
            assert(!movieTitles.isEmpty)
        }
    }
    
    // API Tests
    
    func testFetchMovie() {
        let movieId = 724089
        var movieResponse: Movie? = nil
        let movieExpectation = expectation(description: "movie detail")
        
        networkManager.fetchMovie(id: movieId) { (res) in
            switch res {
                
            case .success(let value):
                movieResponse = value
                movieExpectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 5) { _ in
            print(movieResponse as Any)
            XCTAssertNotNil(movieResponse)
        }
    }
    
    
    // User Defaults
    func testSubscribedMovies() {
        let subscribedMovies = defaultsManager.getSubcriptionsList()
        print(subscribedMovies)
        XCTAssertNotNil(subscribedMovies)
    }
    
    
    // FileManager
    func testDocumentsDirectory() {
        print(handler.documentsDirectory)
        assert(!handler.documentsDirectory.absoluteString.isEmpty)
    }
    
    func testContentsOfDocumentDirectory() {
        assert(handler.flushDocumentsDirectory() == true)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
