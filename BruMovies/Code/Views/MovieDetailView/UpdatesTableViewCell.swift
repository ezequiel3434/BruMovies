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
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.textColor = UIColor.label
        return l
    }()

    
    let descriptionLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.label
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        l.numberOfLines = 0
        l.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\n   It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n\n  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\n   It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        l.sizeToFit()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(headerLabel)
        addSubview(descriptionLabel)
        setUpConstrainst()
    }
    
    func setUpConstrainst(){
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 500)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- functions for the cell
    func setupCell(viewModel: MovieViewModel) {
        
        descriptionLabel.text = viewModel.overview

    }
    
}

