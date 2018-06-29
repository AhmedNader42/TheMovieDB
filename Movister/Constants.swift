//
//  Constants.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import Foundation

// URLS
let BASE_URL = "https://api.themoviedb.org/"
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original"
let BASE_COMMENTS_URL = "https://jsonplaceholder.typicode.com/comments"
let API_KEY = "2c30dae2c31d1624cb9b304e0c9b3e8a"
let SEARCH_URL = "\(BASE_URL)/3/search/movie?api_key=\(API_KEY)&query="

// Identifiers
let ID_SEARCH_CELL = "searchCell"
let ID_DETAILS_CELL = "detailsCell"
let ID_LOADING_CELL = "LoadingCell"
let ID_NOTHING_FOUND_CELL = "NothingFound"
let ID_REPLIES_CELL = "repliesCell"

// NIB Names
let NIB_SEARCH = "searchCell"
let NIB_DETAILS = "DetailsCell"
let NIB_LOADING = "LoadingCell"
let NIB_NOTFOUND = "NothingFoundCell"
let NIB_REPLIES = "RepliesCell"

// Segues
let SEARCH_TO_DETAILS = "searchToDetails"
