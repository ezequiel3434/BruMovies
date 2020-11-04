//
//  CoreGraphicsExtension.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

extension CALayer {
    
    func removeLayerIfExists(_ view: UIView) {
        if let lastLayer = view.layer.sublayers?.last {
            let isPresent = lastLayer is ShimmerLayer
            if isPresent {
                self.removeFromSuperlayer()
            }
        }
    }
}
