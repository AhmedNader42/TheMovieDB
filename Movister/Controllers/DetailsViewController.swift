//
//  DetailsViewController.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit
import Cosmos
class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goingLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var movieRatingView: CosmosView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    let peopleGoing = "500"
    let userName = "Ahmed"
    let price = "1500$"
    
    var currentMovie = Movie()
    var image: UIImage = #imageLiteral(resourceName: "notfound")
    var mainComments = [Comment]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView setup
        tableView.dataSource = self
        tableView.rowHeight = 400
        
        // NIBs
        let cell = UINib(nibName: "DetailsCell", bundle: nil)
        tableView.register(cell , forCellReuseIdentifier: ID_DETAILS_CELL)
        
        // Rating View setup
        movieRatingView.settings.updateOnTouch = false
        movieRatingView.settings.starMargin = 1
        movieRatingView.settings.totalStars = 10
        movieRatingView.settings.fillMode = .precise
        
        
        // Display the movie details and start fetching the comments
        fetchComments()
        setupMovie()
        tableView.reloadData()
    }

    
    
    // MARK: - Setup
    func setupMovie() {
        nameLabel.text = currentMovie.title
        priceLabel.text = price
        dayLabel.text = currentMovie.releaseDate.components(separatedBy: "-").last!
        let monthNumber = currentMovie.releaseDate.components(separatedBy: "-")[1]
        let dateFormatter = DateFormatter()
        monthLabel.text = dateFormatter.monthSymbols[Int(monthNumber)! - 1]
        mainImage.image = image
//        downloadTask = mainImage.loadImage(url: URL(string: "\(BASE_IMAGE_URL)\(currentMovie.posterURL)")!)
        movieRatingView.rating = currentMovie.rating
    }
    
    func fetchComments() {
        Requests.instance.getComments { (success, comments) in
            if !success { return }
            
            guard let safeComments = comments else { return }
            self.mainComments = safeComments
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID_DETAILS_CELL, for: indexPath) as! detailsCell
        cell.configure(comment: mainComments[indexPath.row])
        return cell
    }
}
