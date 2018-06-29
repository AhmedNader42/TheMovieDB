//
//  ViewController.swift
//  Movister
//
//  Created by Admin on 6/26/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var results = [Movie]()
    var selectedMovie = Movie()
    var isDownloading = false
    var searched = false

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        
        // NIBs
        let searchCell = UINib(nibName: NIB_SEARCH, bundle: nil)
        tableView.register(searchCell, forCellReuseIdentifier: ID_SEARCH_CELL)
        
        let nothingFoundCell = UINib(nibName: NIB_NOTFOUND, bundle: nil)
        tableView.register(nothingFoundCell, forCellReuseIdentifier: ID_NOTHING_FOUND_CELL)
        
        let loadingCell = UINib(nibName: NIB_LOADING, bundle: nil)
        tableView.register(loadingCell, forCellReuseIdentifier: ID_LOADING_CELL)
        tableView.reloadData()
        
        // SearchBar setup
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEARCH_TO_DETAILS {
            guard let destination = segue.destination as? DetailsViewController else { return }
            destination.currentMovie = self.selectedMovie
        }
    }
    
}


// MARK: - TableView
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDownloading {
            return 1
        }
        else if !searched {
            return 0
        }
        else if results.count == 0 {
            return 1
        }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Show the loading cell when there is a download
        if isDownloading{
            let cell = tableView.dequeueReusableCell(withIdentifier: ID_LOADING_CELL,for: indexPath)
            
            // Start the spinner to indicate loading
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            
            return cell
        }
        //The array is empty then there was nothing found
        else if results.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: ID_NOTHING_FOUND_CELL,for: indexPath)
        }
        //Update the cells to display the data in the array
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ID_SEARCH_CELL, for: indexPath) as! searchResultCell
            cell.configure(for: results[indexPath.row])
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add the selected movie to send to the next view
        self.selectedMovie = results[indexPath.row]
        // Deselcet row so it doesn't stay stuck
        tableView.deselectRow(at: indexPath, animated: true)
        // Go to the details view
        performSegue(withIdentifier: SEARCH_TO_DETAILS, sender: nil)
    }
}


// MARK: - SearchBar
extension ViewController: UISearchBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Make sure there is text in the searchBar
        guard let movieName = searchBar.text, !(searchBar.text?.isEmpty)! else { return }
        
        // Reload the tableView to indicate loading
        searched = true
        isDownloading = true
        self.tableView.reloadData()
        
        // Replace with the allowed characters for the search term
        let query = movieName.replacingOccurrences(of: " ", with: "+")
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        Requests.instance.searchForMovie(withName: escapedQuery) { (success, movies) in
            if success == false {
                return
            }
            
            // Reload the view with the data
            self.isDownloading = false
            self.results = movies!
            self.tableView.reloadData()
        }
    }
}
