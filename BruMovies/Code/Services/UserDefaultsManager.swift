//
//  UserDefaultsManager.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 02/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    //MARK: - getter functions
    
    func getNowPlayingList() -> [String] {
        guard let ids = UserDefaults.standard.array(forKey: "NowPlaying") as? [String] else { return [] }
        return ids
    }
    
    func getTopRatedList() -> [String] {
        guard let ids = UserDefaults.standard.array(forKey: "TopRated") as? [String] else { return [] }
        return ids
    }
    
    func getSubcriptionsList() -> [Int] {
        guard let ids = UserDefaults.standard.array(forKey: "Subcriptions") as? [Int] else { return [] }
        return ids
    }
    
    //MARK: - setter functions
    
    func setNowPlayingList(titles: [String]) {
        UserDefaults.standard.set(titles, forKey: "NowPlaying")
    }
    
    func setTopRatedList(titles: [String]) {
        UserDefaults.standard.set(titles, forKey: "TopRated")
    }
    
    func setSubcriptionsList(titles: [Int]){
        UserDefaults.standard.set(titles, forKey: "Subcriptions")
    }
    
    //MARK: - Subcriptions
    
    @discardableResult
    func toggleSubcriptions(id: Int) -> Bool {
        let subcriptions = getSubcriptionsList()
        
        if subcriptions.contains(id) {
            self.removeFromSubcriptions(id: id, subcriptions: subcriptions)
            return false
        } else {
            self.addToSubcriptions(id: id, subcriptions: subcriptions)
            return true
        }
    }
    
    
    @discardableResult
    func removeFromSubcriptions(id: Int, subcriptions: [Int]) -> Bool {
        self.setSubcriptionsList(titles: subcriptions.filter{$0 != id})
        return true
    }
    
    @discardableResult
    func addToSubcriptions(id: Int, subcriptions: [Int]) -> Bool {
        var newSubcriptions = subcriptions
        newSubcriptions.append(id)
        self.setSubcriptionsList(titles: newSubcriptions)
        return true
    }
    
    func checkIfSubcription(id: Int) -> Bool {
        let subcriptions = getSubcriptionsList()
        if subcriptions.contains(id) {
            return true
        } else {
            return false
        }
    }
    
    func clearUserDefaults() {
        UserDefaults.resetStandardUserDefaults()
    }
    
    
}



