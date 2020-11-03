//
//  BoxBind.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 03/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

class BoxBind <T> {
    typealias Listener = (T) -> ()
    
    //MARK: - Variables for the binder
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    //MARK: - Initializers for the binder
    init(_ value: T) {
        self.value = value
    }
    
    //MARK: - functions for the binder
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    
}
