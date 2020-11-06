//
//  TitleCollectionViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 04/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell, ComponentShimmers {
    
    
   

    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    //MARK: - Variables for the cell
    
    override class func description() -> String {
        return "TitleCollectionViewCell"
    }
    
    let cellHeight: CGFloat = 240
    let cornerRadius: CGFloat = 12
    
    let animationDuration: Double = 0.25
    var shimmer: ShimmerLayer = ShimmerLayer()
    
    //MARK: - LifeCycle methods for the cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hideViews()
        
        self.containerView.setCornerRadius(radius: 12)
        self.moviePosterImageView.setCornerRadius(radius: 12)
        self.moviePosterImageView.setShadow(shadowColor: UIColor.label, shadowOpacity: 1, shadowRadius: 10, offset: CGSize(width: 0, height: 2))
        self.moviePosterImageView.setBorder(with: UIColor.label.withAlphaComponent(0.15), 2)
    }
    
    // MARK:- delegate functions for collectionView
    
    func hideViews() {
        ViewAnimationFactory.makeEaseInAnimation(duration: animationDuration, delay: 0) {
            self.moviePosterImageView.setOpacity(to: 0)
            self.movieTitleLabel.setOpacity(to: 0)
            self.movieGenreLabel.setOpacity(to: 0)
        }
       }
       
       func showViews() {
        ViewAnimationFactory.makeEaseInAnimation(duration: animationDuration, delay: 0) {
            self.moviePosterImageView.setOpacity(to: 1)
            self.movieTitleLabel.setOpacity(to: 1)
            self.movieGenreLabel.setOpacity(to: 1)
        }
       }
       
       func setShimmer() {
        DispatchQueue.main.async {
            self.shimmer.removeLayerIfExists(self)
            self.shimmer = ShimmerLayer(for: self.moviePosterImageView, cornerRadius: 12)
            self.layer.addSublayer(self.shimmer)
        }
       }
       
       func removeShimmer() {
        shimmer.removeFromSuperlayer()
       }
       
    //MARK: - functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        setShimmer()
        self.movieTitleLabel.text = viewModel.title
        if viewModel.genreText == "n/a" {
            self.movieGenreLabel.text = viewModel.genreObj?.first?.name
        } else {
            self.movieGenreLabel.text = viewModel.genreText
        }
        
        
        DispatchQueue.global().async {
            viewModel.moviePosterImage.bind {
                guard let posterImage = $0 else {return}
                DispatchQueue.main.async { [unowned self] in
                    self.moviePosterImageView.image = posterImage
                    self.removeShimmer()
                    self.showViews()
                }
            }
        }
    }

}
