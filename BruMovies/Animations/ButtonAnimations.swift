//
//  ButtonAnimations.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

typealias ButtonConfiguration = (symbol: String, configuration:  UIImage.SymbolConfiguration, buttonTint: UIColor)

struct ButtonAnimationFactory {
    
    func makeActivateAnimation(for button: UIButton) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
//            button.setImage(UIImage(systemName: config.symbol, withConfiguration: config.configuration), for: .normal)
            button.tintColor = .red
            button.setTitle("SUSCRIPTO", for: .normal)
            button.backgroundColor = .red
        })
    }
    
    func makeDeactivateAnimation(for button: UIButton) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
//            button.setImage(UIImage(systemName: config.symbol, withConfiguration: config.configuration), for: .normal)
            
            button.setTitle("SUSCRIBIRME", for: .normal)
            button.backgroundColor = .blue
        })
    }
    
    
    func heartActivateAnimation(for button: UIButton, _ config: ButtonConfiguration) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.setImage(UIImage(systemName: config.symbol, withConfiguration: config.configuration), for: .normal)
            button.tintColor = config.buttonTint
        })
    }
    
    func heartDeactivateAnimation(for button: UIButton, _ config: ButtonConfiguration) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.setImage(UIImage(systemName: config.symbol, withConfiguration: config.configuration), for: .normal)
            button.tintColor = config.buttonTint
        })
    }
}
