//
//  SearchTableViewController.swift
//  iMusic
//
//  Created by Akan Akysh on 1/28/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }

    // MARK: - Table view data source, delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        return cell
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            let url = "https://itunes.apple.com/search?term=\(searchText )"
            let parameters = ["term": "\(searchText)", "limit": "10"]
            
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
                
                if let error = dataResponse.error {
                    print("Error recieved requesting data: \(error.localizedDescription)")
                }
                
                guard let data = dataResponse.data else { return}
                let decoder = JSONDecoder()
                
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    self.tracks = objects.results
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            }
            
        })
    }
}
