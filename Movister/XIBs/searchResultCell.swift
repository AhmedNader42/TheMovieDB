//
//  searchResultCell.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit
import Alamofire

class searchResultCell: UITableViewCell {

    // MARK: - Variables
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var adultContentImageView: CircleImage!
    
    // MARK: - Variables
    var downloadTask: URLSessionDownloadTask?
    
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        // Cancel the image download if the cell is being reused.
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func configure(for movie: Movie) {
        nameLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        overviewTextView.text = movie.overview
        
        if movie.adult {
            self.adultContentImageView.image = #imageLiteral(resourceName: "adult")
        } else {
            self.adultContentImageView.image = #imageLiteral(resourceName: "notAdult")
        }
        downloadTask = movieImage.loadImage(url: URL(string: "\(BASE_IMAGE_URL)\(movie.posterURL)")!)
    }
}



