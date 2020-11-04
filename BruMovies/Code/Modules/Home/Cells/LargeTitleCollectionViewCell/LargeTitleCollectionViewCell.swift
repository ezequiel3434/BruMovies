//
//  LargeTitleCollectionViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class LargeTitleCollectionViewCell: UICollectionViewCell, ComponentShimmers {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backdropMoviewIMageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    
    //MARK: - Vriables for the cell
    override class func description() -> String {
        return "LargeTitleCollectionViewCell"
    }
    
    let animationDuration: Double = 0.25
    let cellHeight: CGFloat = 240
    let cornerRadius: CGFloat = 8
    
    var shimer: ShimmerLayer = ShimmerLayer()
    
    //MARK: - LifeCycle methods for the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.setCornerRadius(radius: cornerRadius)
    }
    
    
    
    // MARK:- delegate functions for collectionView
    
    func hideViews() {
        
    }
    
    func showViews() {
        
    }
    
    func setShimmer() {
        
    }
    
    func removeShimmer() {
        
    }

}
