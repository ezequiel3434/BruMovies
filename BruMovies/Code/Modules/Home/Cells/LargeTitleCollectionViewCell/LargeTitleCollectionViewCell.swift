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
        self.backdropMoviewIMageView.setCornerRadius(radius: cornerRadius)
        self.backdropMoviewIMageView.setShadow(shadowColor: UIColor.label, shadowOpacity: 1, shadowRadius: 10, offset: CGSize(width: 0, height: 2))
        self.backdropMoviewIMageView.setBorder(with: UIColor.label.withAlphaComponent(0.15), 2)
    }
    
    // MARK:- delegate functions for collectionView
    
    func hideViews() {
        ViewAnimationFactory.makeEaseInAnimation(duration: animationDuration, delay: 0) {
            self.backdropMoviewIMageView.setOpacity(to: 0)
            self.movieTitleLabel.setOpacity(to: 0)
            self.movieGenreLabel.setOpacity(to: 0)
            self.movieReleaseLabel.setOpacity(to: 0)
        }
    }
    
    func showViews() {
        self.backdropMoviewIMageView.setOpacity(to: 1)
        self.movieTitleLabel.setOpacity(to: 1)
        self.movieGenreLabel.setOpacity(to: 1)
        self.movieReleaseLabel.setOpacity(to: 1)
    }
    
    func setShimmer() {
        DispatchQueue.main.async { [unowned self] in
            self.shimer.removeLayerIfExists(self)
            self.shimer = ShimmerLayer(for: self.backdropMoviewIMageView, cornerRadius: 12)
            self.layer.addSublayer(self.shimer)
        }
    }
    
    func removeShimmer() {
        shimer.removeFromSuperlayer()
    }
    
    //MARK: - Functions for the cell
    func setupCell(viewModel: MovieViewModel?) {
        setShimmer()
        guard let viewModel = viewModel else { return }
        self.movieTitleLabel.text = viewModel.title
        self.movieGenreLabel.text = viewModel.genreText
        self.movieReleaseLabel.text = viewModel.releaseDate
        
        DispatchQueue.global().async {
            viewModel.movieBackDropImage.bind {
                guard let backDropImage = $0 else {return}
                DispatchQueue.main.async { [unowned self] in
                    self.backdropMoviewIMageView.image = backDropImage
                    self.removeShimmer()
                    self.showViews()
                }
            }
        }
    }

}
