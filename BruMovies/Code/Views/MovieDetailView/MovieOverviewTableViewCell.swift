//
//  GameOverviewTableViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {
var state = false
    let buttonAnimationFactory: ButtonAnimationFactory = ButtonAnimationFactory()
    
    let movieImageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 25
        img.image = UIImage(named: "logo")
        img.layer.masksToBounds = true
        
        return img
    }()
    
    let movieTitle:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textColor = UIColor.label
        let attributedText = NSMutableAttributedString(string:"Titulo" , attributes:[NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        l.attributedText = attributedText
        return l
    }()
    
    let movieGenre:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        let attributedText = (NSAttributedString(string: "genero" , attributes:
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15 , weight:.regular), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        l.attributedText = attributedText
        return l
    }()
    
   
    
    let getButton: UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 17.5
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitle("SUSCRIBIRME", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.blue, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return btn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(getButton)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieGenre)
        
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            movieImageView.heightAnchor.constraint(equalToConstant: 170),
            
            movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieTitle.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieGenre.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
            movieGenre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            getButton.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 55),
            getButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            getButton.widthAnchor.constraint(equalToConstant: 120),
            getButton.heightAnchor.constraint(equalToConstant: 35)

            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK:- functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        
        movieTitle.text = viewModel.title
        if viewModel.genreText == "n/a" {
            self.movieGenre.text = viewModel.genreObj?.first?.name
        } else {
            self.movieGenre.text = viewModel.genreText
        }
        
        
        DispatchQueue.global().async {
            viewModel.moviePosterImage.bind {
                guard let posterImage = $0 else { return }
                DispatchQueue.main.async { [unowned self] in
                    self.movieImageView.image = posterImage
                    
                }
            }
        }
    }
}



