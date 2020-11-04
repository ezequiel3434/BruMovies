//
//  UIViewAnimations.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

enum ViewAnimationFactory {
    static func makeEaseInAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            action()
        })
    }
    static func makeEaseInOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            action()
        })
    }
    static func makeEaseOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            action()
        })
    }
    
    static func makeSimpleAnimation(duration: TimeInterval, action: @escaping() -> Void){
        UIView.animate(withDuration: duration) {
            action()
        }
    }
}
