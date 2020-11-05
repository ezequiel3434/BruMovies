//
//  UpdatesTableViewCell.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {

    let headerLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "RESUMEN"
        l.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        l.textColor = .black
        return l
    }()
    
//    let versionLabel:UILabel = {
//        let l = UILabel()
//        l.text = "Version 1.0.16"
//        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
//        l.textColor = .darkGray
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
    
//    let versionHistoryLabel:UILabel = {
//        let l = UILabel()
//        l.text = "Version History"
//        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        l.textColor = .systemBlue
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
    
//    let weekAgoLabel:UILabel = {
//        let l = UILabel()
//        l.text = "3w ago"
//        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
//        l.textColor = .darkGray
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
    
    let descriptionLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        l.numberOfLines = 0
        l.text = "Call of Duty offers new seasons monthly with characters, weapons, maps, and battle pass content updates. All new modes and themed events based on seasonal themes.\n\n  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\n   It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n\n  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\n   It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        l.sizeToFit()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(headerLabel)
        //addSubview(versionLabel)
        //addSubview(versionHistoryLabel)
        //addSubview(weekAgoLabel)
        addSubview(descriptionLabel)
        setUpConstrainst()
    }
    
    func setUpConstrainst(){
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 25),
            
//            versionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 7),
//            versionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            versionLabel.heightAnchor.constraint(equalToConstant: 16),
            
//            versionHistoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            versionHistoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
//            weekAgoLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 7),
//            weekAgoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 500)
//            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        
        descriptionLabel.text = viewModel.overview
        
//
//        DispatchQueue.global().async {
//            viewModel.moviePosterImage.bind {
//                guard let posterImage = $0 else { return }
//                DispatchQueue.main.async { [unowned self] in
//                    self.gameImageView.image = posterImage
//
//                }
//            }
//        }
    }
    
}

