//
//  ViewController.swift
//  TopStories
//
//  Created by Maitree Bain on 11/25/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

enum SearchScope {
    case title // title of headline
    case abstract // a summary of headline
    
}

class NewsFeedController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    //search bar has a delegate
    
    
    var headlines = [NewsHeadline]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.title // default value is 0 "Title" scope
    
    //create a variable called searchQuery that filters values
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(HeadlinesData.getHeadlines())
        tableView.dataSource = self
        loadData()
        tableView.delegate = self
        searchBar.delegate = self
    }

    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }

    func filterHeadlines(for searchText: String) {
        //guarding against an empty search query
        //return here simply does nothing, just exits the method
        guard !searchText.isEmpty else { return }
        headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased())
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsDetailController = segue.destination as? NewsDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name")
        }
        let headline = headlines[indexPath.row]
        
        newsDetailController.newsHeadline = headline
    }
    
    
    
    }

extension NewsFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else {
            fatalError("couldn't dequeue a HeadlineCell")
        }
        
         let headline = headlines[indexPath.row]
        
        cell.configureCell(for: headline)
        
        return cell
    }
}

extension NewsFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension NewsFeedController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //filter our data for the table view
        //dismiss keyboard
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //real time searching as user types
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
        // filterHeadlines(for: searchText)
    
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("selectedScrope: \(selectedScope)")
        
        switch selectedScope {
        case 0:
            currentScope = .title
        case 1:
            currentScope = .abstract
        default:
            print("not a valid scope")
        }
    }

}
