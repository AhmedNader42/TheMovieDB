//
//  repliesCell.swift
//  Movister
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit

class repliesCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: CircleImage!
    @IBOutlet weak var bodyTextView: UITextView!
    


    func configure(reply: Replies) {
        nameLabel.text = reply.name
        bodyTextView.text = reply.body
    }
    

}
