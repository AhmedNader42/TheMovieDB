//
//  Requests.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Requests {
    // MARK: - Variables
    static let instance = Requests()
    
    // MARK: - Methods
    
    // Gets the list of movies from a movie name.
    func searchForMovie(withName queryString: String
        , completion : @escaping (_ : Bool,_ :[Movie]?) -> ()) {
        
        Alamofire.request("\(SEARCH_URL)\(queryString)").responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                var movies = [Movie]()
            
                // Get the results array our of the JSON data
                guard let results = json["results"].array else { return }
                
                // Add the results in the movies array.
                for each in results {
                    movies.append(Movie(title: each["title"].stringValue,
                                        rating: each["vote_average"].doubleValue,
                                        id: each["id"].intValue,
                                        posterURL: each["poster_path"].stringValue,
                                        releaseDate: each["release_date"].stringValue,
                                        overview: each["overview"].stringValue,
                                        adult: each["adult"].boolValue))
                }
                
                // Return success and the movies fetched
                completion(true, movies)
            } catch {
                // Return not success and nil for the movies
                completion(false, nil)
            }
        }
    }
    
    // Get the comments from the placeholder API
    func getComments(completion : @escaping (_ : Bool,_ :[Comment]?) -> ()) {
        Alamofire.request(BASE_COMMENTS_URL).responseJSON { (response) in
            
            // Get the data out of the response
            guard let data = response.data else { return }
            
            do {
                let json = try JSON(data: data).array
                var comments = [Comment]()
                
                // Get the results array out of the JSON data
                guard let results = json else { return }
                
                // Iterate over all of the results given.
                var i = 0
                while i < results.count {
                    // Append the first result for each postId as the main comment.
                    var mainComment = Comment(postId: results[i]["postId"].intValue ,
                                          id: results[i]["id"].intValue,
                                          name: results[i]["name"].stringValue,
                                          body: results[i]["body"].stringValue,
                                          email: results[i]["email"].stringValue,
                                          replies: [Replies]())
                    
                    // All the following comments that have the same postId are added to the replies of the main comment.
                    var samePost = true
                    while samePost {
                        i += 1
                        // Break if the list is finished to avoid runtime crash.
                        if i >= results.count { break }
                        
                        // if the current result has a different id from the main comment it's a new post so you break.
                        if results[i]["postId"].intValue != mainComment.postId {
                            samePost = false
                            break
                        }
                        
                        // Add the reply to the main comment replies array
                        mainComment.replies.append(Replies(postId:results[i]["postId"].intValue,
                                                       id: results[i]["id"].intValue,
                                                       name: results[i]["name"].stringValue,
                                                       body: results[i]["body"].stringValue,
                                                       email: results[i]["email"].stringValue
                                                ))
                    }
                    comments.append(mainComment)
                }
                
                // Return success and the comments fetched
                completion(true,comments)
            } catch {
                // Return not success and nil for the comments
                completion(false, nil)
            }
        }
    }
    
}
