//
//  RootTabBarController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 02/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import UIKit

class RootTabViewController: UITabBarController {
    
    //MARK: - Variables for the view controller
    
    override class func description() -> String {
        "RootTabViewController"
    }
    
    //MARK: - Life cycle for the view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.selectedIndex = 0
        
    }
    
    //MARK: - Functions for the view controller
    func setupTabs() {
        self.tabBar.tintColor = UIColor.label
        self.tabBar.barStyle = .default
        
        guard let homeViewController = storyboard?.instantiateViewController(identifier: HomeViewController.description()) else { return }
        let searchViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: MovieSearchViewController.description())
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house")?.withRenderingMode(.automatic), selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.automatic))
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        homeViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 2.0)
        
        
        
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.automatic), selectedImage: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.automatic))
        searchViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        searchViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 2.0)
        
        viewControllers = [homeViewController, searchViewController]
        
        
    }
    
    
}
