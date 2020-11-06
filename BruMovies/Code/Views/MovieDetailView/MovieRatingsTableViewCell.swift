//
//  GameRatingsTableViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class MovieRatingsTableViewCell: UITableViewCell {

    let ratings:UILabel = {
        let l = UILabel()
        l.text = "4.4"
        l.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        l.textColor = CustomColors.lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let ratingCount:UILabel = {
        let l = UILabel()
        l.text = "48.7K Ratings"
        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
        l.textColor = CustomColors.lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let stackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 3
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let star1:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = CustomColors.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let star2:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = CustomColors.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let star3:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = CustomColors.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let star4:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = CustomColors.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let star5:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = CustomColors.lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let ageCountLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "17+"
        l.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        l.textColor = CustomColors.lightGray
        return l
    }()
    
    let ageLabel:UILabel = {
        let l = UILabel()
        l.text = "Age"
        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
        l.textColor = CustomColors.lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
//    let rankLabel:UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "No1"
//        l.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
//        l.textColor = CustomColors.lightGray
//        return l
//    }()
    
//    let categoryLabel:UILabel = {
//        let l = UILabel()
//        l.text = "Action"
//        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        l.textColor = CustomColors.lightGray
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(ratings)
        addSubview(ratingCount)
        addSubview(stackView)
        addSubview(ageCountLabel)
        addSubview(ageLabel)
//        addSubview(rankLabel)
//        addSubview(categoryLabel)
        stackView.addArrangedSubview(star1)
        stackView.addArrangedSubview(star2)
        stackView.addArrangedSubview(star3)
        stackView.addArrangedSubview(star4)
        stackView.addArrangedSubview(star5)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            ratings.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ratings.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: ratings.trailingAnchor, constant: 5),
            stackView.widthAnchor.constraint(equalToConstant: 110),
            stackView.heightAnchor.constraint(equalToConstant: 17),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            ratingCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ratingCount.topAnchor.constraint(equalTo: ratings.bottomAnchor, constant: 2),
            
            ageCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            ageCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            ageLabel.topAnchor.constraint(equalTo: ageCountLabel.bottomAnchor, constant: 2),
            ageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
            
//            rankLabel.trailingAnchor.constraint(equalTo: ageCountLabel.leadingAnchor, constant: -70),
//            rankLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            categoryLabel.trailingAnchor.constraint(equalTo: ageLabel.leadingAnchor, constant: -76),
//            categoryLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        let stars = [star1,star2,star3,star4,star5]
        let rating = viewModel.ratingText.count
        for i in 0..<rating {
            stars[i].setBackgroundImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        ratings.text = viewModel.scoreText
        ratingCount.text = "\(viewModel.voteCount) Ratings"
        
        ageCountLabel.text = viewModel.yearText
        ageLabel.text = "Lanzamiento"
        
//        DispatchQueue.global().async {
//            viewModel.moviePosterImage.bind {
//                guard let posterImage = $0 else { return }
//                DispatchQueue.main.async { [unowned self] in
//                    let colors = posterImage.getColors()
//                    
//                    self.backgroundColor = colors?.background
//
//                }
//            }
//        }
    }
}

