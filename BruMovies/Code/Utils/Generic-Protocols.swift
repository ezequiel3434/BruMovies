//
//  Generic-Protocols.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation


protocol ComponentShimmers {
    var animationDuration: Double { get }

    func hideViews()
    func showViews()
    func setShimmer()
    func removeShimmer()
}
