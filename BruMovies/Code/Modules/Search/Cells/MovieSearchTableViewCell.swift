//
//  MovieSearchTableViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 06/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class MovieSearchViewCell: UITableViewCell, ComponentShimmers {
    
    // MARK:- outlets for the cell
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    
    // MARK:- variables for the cell
    override class func description() -> String {
        return "MovieSearchViewCell"
    }
    
    
    let animationDuration: Double = 0.25
    let cornerRadius: CGFloat = 12
    let rowHeight: CGFloat = 200
    
    var shimmer: ShimmerLayer = ShimmerLayer()
    var searchViewModel: MovieSearchViewModel?
    
    var id : Int = 0
    
    var likedConfiguration: ButtonConfiguration  = (symbol: "suit.heart.fill", configuration: UIImage.SymbolConfiguration(pointSize: 27, weight: .medium, scale: .default), buttonTint: UIColor.systemPink)
    var normalConfiguation: ButtonConfiguration  = (symbol: "suit.heart", configuration: UIImage.SymbolConfiguration(pointSize: 27, weight: .medium, scale: .default), buttonTint: UIColor.tertiaryLabel)
    let buttonAnimationFactory: ButtonAnimationFactory = ButtonAnimationFactory()
    
    // MARK:- lifeCycle methods for the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        hideViews()

        self.moviePosterImageView.setCornerRadius(radius: cornerRadius - 4)
        self.containerView.setCornerRadius(radius: cornerRadius)
        self.containerView.setShadow(shadowColor: UIColor.label, shadowOpacity: 0.25, shadowRadius: 10, offset: CGSize(width: 1, height: 1))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.containerView.setShadow(shadowColor: UIColor.label, shadowOpacity: 0.25, shadowRadius: 10, offset: CGSize(width: 1, height: 1))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideViews()
        self.setButton(with: normalConfiguation)
    }
    
    // MARK:- @objc funcs & IBActions for the viewController
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        guard let searchViewModel = searchViewModel else { return }
        let status = searchViewModel.subscribePressed(id: id)
        if (status) {
            buttonAnimationFactory.heartActivateAnimation(for: favoriteButton, likedConfiguration)
        } else {
            buttonAnimationFactory.heartDeactivateAnimation(for: favoriteButton, normalConfiguation)
        }
    }
    
    
    // MARK:- delegate functions for collectionView
    func hideViews() {
        ViewAnimationFactory.makeEaseOutAnimation(duration: animationDuration, delay: 0) {
            self.moviePosterImageView.setOpacity(to: 0)
            self.movieTitleLabel.setOpacity(to: 0)
            
            self.favoriteButton.setOpacity(to: 0)
        }
    }
    
    func showViews() {
        ViewAnimationFactory.makeEaseOutAnimation(duration: animationDuration, delay: 0) {
            self.moviePosterImageView.setOpacity(to: 1)
            self.movieTitleLabel.setOpacity(to: 1)
            
            self.favoriteButton.setOpacity(to: 1)
        }
    }
    
    func setShimmer() {
        DispatchQueue.main.async { [unowned self] in
            self.shimmer.removeLayerIfExists(self)
            self.shimmer = ShimmerLayer(for: self.containerView, cornerRadius: 12)
            self.layer.addSublayer(self.shimmer)
        }
    }
    
    func removeShimmer() {
        shimmer.removeFromSuperlayer()
    }
    
    
    // MARK:- functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        setShimmer()
        if let status = self.searchViewModel?.checkIfSubscribed(id: viewModel.id) {
            if (status) {
                self.setButton(with: likedConfiguration)
            }
        }
        
        self.movieTitleLabel.text = viewModel.title
        self.movieGenreLabel.text = viewModel.genreText
        
        DispatchQueue.global().async {
            viewModel.moviePosterImage.bind {
                guard let posterImage = $0 else { return }
                self.id = viewModel.id
                DispatchQueue.main.async { [unowned self] in
                    self.moviePosterImageView.image = posterImage
                    self.removeShimmer()
                    self.showViews()
                }
            }
        }
    }
    
    func setButton(with config: ButtonConfiguration) {
        self.favoriteButton.setImage(UIImage(systemName: config.symbol, withConfiguration: config.configuration), for: .normal)
        self.favoriteButton.tintColor = config.buttonTint
    }
}
