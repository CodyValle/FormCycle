//
//  SearchPage.swift
//  FormCycle
//
//  Created by John Ragan on 2/22/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit


class SearchPageViewController: UITableViewController  {
    
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var address: UILabel!
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Name"]//, "City", "State", "Brand"]
        tableView.tableHeaderView = searchController.searchBar
        
        candies = [
            Candy(category:"Name", name:"John Ragan", address:"1234 N Howard St."),
            Candy(category:"Name", name:"Cody Valle", address:"512 N Main St."),
            Candy(category:"Name", name:"Adam Cross", address:"10909 E. Farr Rd"),
            Candy(category:"Name", name:"Jack Black", address:"777 N gold st."),
            Candy(category:"Name", name:"Ryder Cliff", address:"12 W Euclid"),
            Candy(category:"Name", name:"Jo Topper", address:"634 S Division St"),
            Candy(category:"Name", name:"Jamie Long", address:"8 W Wall"),
            Candy(category:"Name", name:"Javier Lewis", address:"45 N Long rd"),
            Candy(category:"Name", name:"Kelly Rippa", address:"1212 E Jack Rd")]
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCandies.count
        }
        return candies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let candy: Candy
        if searchController.active && searchController.searchBar.text != "" {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel!.text = candy.name
        cell.detailTextLabel!.text = candy.address
        //cell.address!.text = candy.address
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({( candy : Candy) -> Bool in
            let categoryMatch = (scope == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Candy
                if searchController.active && searchController.searchBar.text != "" {
                    candy = filteredCandies[indexPath.row]
                } else {
                    candy = candies[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

extension SearchPageViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchPageViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    
    
}



    