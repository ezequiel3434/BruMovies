//
//  CustomNavBar.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class CustomNavBar: UIView {

    var controller:MovieDetailViewController?
    
    let cardView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.masksToBounds = true
        return v
    }()
    
    let gameThumbImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logo")
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
//    let getButton:UIButton = {
//        let btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.layer.cornerRadius = 17.5
//        btn.backgroundColor = UIColor.systemBlue
//        btn.setTitle("GET", for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        return btn
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cardView)
        cardView.addSubview(gameThumbImage)
        //cardView.addSubview(getButton)
        setUpConstraints()
        gameThumbImage.transform = CGAffineTransform(translationX: 0, y: +50)
       // getButton.transform = CGAffineTransform(translationX: 0, y: +50)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gameThumbImage.widthAnchor.constraint(equalToConstant: 45),
            gameThumbImage.heightAnchor.constraint(equalToConstant: 70),
            gameThumbImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            gameThumbImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
            
//            getButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
//            getButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
//            getButton.widthAnchor.constraint(equalToConstant: 80),
//            getButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- functions for the cell
       func setupNav(viewModel: MovieViewModel) {
           
           
           DispatchQueue.global().async {
               viewModel.moviePosterImage.bind {
                   guard let posterImage = $0 else { return }
                   DispatchQueue.main.async { [unowned self] in
                       self.gameThumbImage.image = posterImage
                       
                   }
               }
           }
       }
}

