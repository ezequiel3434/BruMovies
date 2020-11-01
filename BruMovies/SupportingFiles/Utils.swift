//
//  Utils.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 01/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

class Utils {
    static let dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-mm-dd"
        return dateformatter
    }()
}
