//
//  StrechyHeaderView.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class StrechyHeaderView: UIView {

    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    var imageView: UIImageView!
    
    var containerViewHeight = NSLayoutConstraint()
    
    
    let backButton: UIButton = {
        let backButtonImage = UIImage(named:"back")?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 100, width: 50, height: 50)
        backButton.backgroundColor = .white
        backButton.layer.borderWidth = 3
        backButton.layer.cornerRadius = 25
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .black
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)

        
        
        return backButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        setViewConstraints()
    }
     
       
    
    func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        backButton.isUserInteractionEnabled = true
        containerView.addSubview(imageView)
        containerView.addSubview(backButton)
        
        
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- functions for the cell
    func setupView(viewModel: MovieViewModel) {
        
        
        DispatchQueue.global().async {
            viewModel.movieBackDropImage.bind {
                guard let backDropImage = $0 else { return }
                DispatchQueue.main.async { [unowned self] in
                    self.imageView.image = backDropImage
                    
                }
            }
        }
    }
    
   
    
}
