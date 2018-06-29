//
//  Comment.swift
//  Movister
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import Foundation


struct Comment {
    var postId = 0
    var id = 0
    var name = ""
    var body = ""
    var email = ""
    var replies = [Replies]()
}


struct Replies {
    var postId = 0
    var id = 0
    var name = ""
    var body = ""
    var email = ""
}
