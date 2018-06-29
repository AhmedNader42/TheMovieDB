//
//  detailsCell.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit

class detailsCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var likeButton: UIButton!
    
    
    // MARK: - Variables
    let likes = "10 Likes"
    let date = "2 Months Ago"
    var currentComment = Comment()
    var liked = false
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bodyImageView.layer.cornerRadius = 20
        bodyImageView.clipsToBounds = true
        
        // TableView setup
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        // NIBs
        let replyCell = UINib(nibName: NIB_REPLIES, bundle: nil)
        tableView.register(replyCell, forCellReuseIdentifier: ID_REPLIES_CELL)
        
        tableView.reloadData()
    }
    
    
    func configure(comment: Comment) {
        currentComment = comment
        mainNameLabel.text = comment.name
        dateLabel.text = date
        bodyLabel.text = comment.body
        likesCounter.text = likes
        commentsCounter.text = "\(comment.replies.count) Comments"
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if liked {
            likeButton.setImage(UIImage(named: "heart"), for: UIControlState.normal)
        } else {
            likeButton.setImage(UIImage(named: "heartRed"), for: UIControlState.normal)
        }
        liked = !liked
    }
}


// MARK: - TableView
extension detailsCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentComment.replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID_REPLIES_CELL, for: indexPath) as! repliesCell
        cell.configure(reply: currentComment.replies[indexPath.row])
        
        return cell
    }
}

