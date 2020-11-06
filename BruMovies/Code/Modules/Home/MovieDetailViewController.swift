//
//  MovieDetailViewController.swift
//  BruMovies
//
//  Created by Ezequiel Parada Beltran on 05/11/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import UIImageColors

class MovieDetailViewController: UIViewController {
    
    
    override class func description() -> String {
        "MovieDetailViewController"
    }
    
    let defaultsManager = UserDefaultsManager()
    let networkManager = NetworkManager.shared
    let fileHandler = FileHandler()
    
    var viewModel: MovieViewModel!
    var movieListViewModel: MovieListViewModel?
    
    var detailViewModel: MovieDetailViewModel!
    let buttonAnimationFactory: ButtonAnimationFactory = ButtonAnimationFactory()
    var colors: UIImageColors?
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
//        tv.overrideUserInterfaceStyle = .dark
//        tv.backgroundColor = .systemBackground
        tv.backgroundColor = colors?.background.withAlphaComponent(0.8)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(MovieOverviewTableViewCell.self, forCellReuseIdentifier: "MovieOverviewTableViewCell")
        tv.register(MovieRatingsTableViewCell.self, forCellReuseIdentifier: "MovieRatingsTableViewCell")
        tv.register(UpdatesTableViewCell.self, forCellReuseIdentifier: "UpdatesTableViewCell")
        tv.showsVerticalScrollIndicator = false
        
        
        
        return tv
    }()
    
    lazy var navBar:CustomNavBar = {
        let v = CustomNavBar()
        v.controller = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.overrideUserInterfaceStyle = .dark
        // not working..
        v.backgroundColor = colors?.background.withAlphaComponent(0.8)
        
        v.layer.shadowRadius = 10
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.1).cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize(width: 0, height: 10)
        return v
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailViewModel = MovieDetailViewModel(movieId: viewModel.id, handler: fileHandler, networkManager: networkManager, defaultsManager: defaultsManager)
        
        setupViews()
        
        
    }
    
    func setupViews() {
        navBar.setupNav(viewModel: viewModel)
        navBar.alpha = 0
        
        
        
        
        
        view.addSubview(tableView)
        view.addSubview(navBar)
        tableView.pin(to: view)
        setUpConstraints()
        
        let headerView = StrechyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        headerView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        headerView.setupView(viewModel: viewModel)
        self.tableView.tableHeaderView = headerView
        
    }
    
    func setupButton(button: UIButton) {
        if let status = self.detailViewModel?.checkIfSubscribed(id: viewModel.id) {
            if (status) {
                button.tintColor = .red
                button.setTitle("SUSCRIPTO", for: .normal)
                button.backgroundColor = .red
                
            }
        }
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    @objc func backButtonPressed() {
       self.navigationController?.popViewController(animated: true)
               
               }
    
    @objc func likeButtonPressed(_ sender: UIButton) {
        
        
        guard let viewModel = viewModel, let detailViewModel = detailViewModel, let movieListViewModel = movieListViewModel else {
            
            return }
        let status = detailViewModel.subscribePressed(id: viewModel.id)
        movieListViewModel.getSubscribedMovies()
        
        if (status) {
            buttonAnimationFactory.makeActivateAnimation(for: sender)
        } else {
            buttonAnimationFactory.makeDeactivateAnimation(for: sender)
        }
    }

}

extension MovieDetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieOverviewTableViewCell", for: indexPath) as! MovieOverviewTableViewCell
            cell.backgroundColor = .clear
//            cell.overrideUserInterfaceStyle = .dark
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.frame.width)
            setupButton(button: cell.getButton)
            cell.getButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
            cell.movieTitle.textColor = colors?.detail
            cell.setupCell(viewModel: viewModel)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRatingsTableViewCell", for: indexPath) as! MovieRatingsTableViewCell
//            cell.backgroundColor = .white
            cell.backgroundColor = .clear
//            cell.overrideUserInterfaceStyle = .dark
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            cell.setupCell(viewModel: viewModel)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpdatesTableViewCell", for: indexPath) as! UpdatesTableViewCell
            cell.backgroundColor = .clear
//            cell.overrideUserInterfaceStyle = .dark
//            cell.backgroundColor = .systemBackground
            cell.headerLabel.textColor = colors?.secondary
            cell.descriptionLabel.textColor = colors?.primary
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            cell.setupCell(viewModel: viewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        if indexPath.row == 1 {
            return 75
        }
        if indexPath.row == 2 {
            return 600
        }
        return CGFloat()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StrechyHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        let y = scrollView.contentOffset.y
        let v = y/210
        let value = Double(round(100*v)/100)
        print(value)
        // It return 1 when header end reaches the height of navbar which is 160.
        
        if value >= 1.0 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.navBar.alpha = 1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4) {
                self.navBar.gameThumbImage.transform = CGAffineTransform(translationX: 0, y: 0)
//                self.navBar.getButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.navBar.alpha = 0
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4) {
                self.navBar.gameThumbImage.transform = CGAffineTransform(translationX: 0, y: +50)
//                self.navBar.getButton.transform = CGAffineTransform(translationX: 0, y: +50)
            }
        }
    }
    
}
