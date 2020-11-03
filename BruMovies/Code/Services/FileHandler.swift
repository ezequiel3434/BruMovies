//
//  FileManager.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 02/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct FileHandler {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    func getPathForImage(id: Int, imageType: MovieListImage) -> URL {
        let pathComponent = "\(id)_\(imageType.rawValue).jpg"
        return documentsDirectory.appendingPathComponent(pathComponent)
    }
    
    func checkIfFileExists(id: Int, imageType: MovieListImage) -> Bool {
        let pathComponent = "\(id)_\(imageType.rawValue).jpg"
        return FileManager.default.fileExists(atPath: documentsDirectory.appendingPathComponent(pathComponent).path)
    }
    
    func flushDocumentsDirectory() -> Bool {
        guard let paths = try? FileManager.default.contentsOfDirectory(at: self.documentsDirectory, includingPropertiesForKeys: nil) else { return false }
        
        for path in paths {
            try? FileManager.default.removeItem(at: path)
        }
        return true
    }
    
    
}
