//
//  SearchPage.swift
//  FormCycle
//
//  Created by John Ragan on 2/22/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON


class SearchPageViewController: UITableViewController  {
    
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var address: UILabel!
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    //var records = [WorkOrder]()
    var records = [Record]()
    var filteredRecords = [Record]()
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
        //Load data
        records.removeAll()
        
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["open"] = "Y"
        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if (succ) {
                if (retjson.count > 0) {
                    for var i = 0; i < retjson.count; i++ {
                        self.records.append(Record(category: "Name",
                            fname: Crypto.decrypt(retjson[i]["fname"].string!),
                            lname: Crypto.decrypt(retjson[i]["lname"].string!),
                            address: Crypto.decrypt(retjson[i]["address"].string!),
                            phone: Crypto.decrypt(retjson[i]["phone"].string!),
                            bikeType: retjson[i]["brand"].string!,
                            bikeModel: retjson[i]["model"].string!,
                            orderID:   retjson[i]["workid"].string!))
//                            orderID:   retjson[i]["workid"].string!,
//                            tune:      retjson[i]["tune"].string!,
//                            bikeType:  retjson[i]["brand"].string!,
//                            model:     retjson[i]["model"].string!,
//                            lname:     Crypto.decrypt(retjson[i]["lname"].string!)))
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    }
                }
                //else you are done- TO DO LATER
                return true
            }
            return false
        })

//        records = [
//            Record(category:"Name", name:"John Ragan", address:"1234 N Howard St."),
//            Record(category:"Name", name:"Cody Valle", address:"512 N Main St."),
//            Record(category:"Name", name:"Adam Cross", address:"10909 E. Farr Rd"),
//            Record(category:"Name", name:"Jack Black", address:"777 N gold st."),
//            Record(category:"Name", name:"Ryder Cliff", address:"12 W Euclid"),
//            Record(category:"Name", name:"Jo Topper", address:"634 S Division St"),
//            Record(category:"Name", name:"Jamie Long", address:"8 W Wall"),
//            Record(category:"Name", name:"Javier Lewis", address:"45 N Long rd"),
//            Record(category:"Name", name:"Kelly Rippa", address:"1212 E Jack Rd")]
        
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
            return filteredRecords.count
        }
        return records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchPageTableViewCell
        var order = records[indexPath.row]
        if searchController.active && searchController.searchBar.text != "" {
            order = filteredRecords[indexPath.row]
        } else {
            order = records[indexPath.row]
        }
        cell.firstName.text = order.fname
        cell.lastName.text = order.lname
        cell.address.text = order.address
        cell.phone.text = order.phone
        cell.bikeType.text = order.bikeType
        cell.bikeModel.text = order.bikeModel
        //cell.textLabel!.text = order.name
        //cell.detailTextLabel!.text = order.address
        //cell.address!.text = Record.address
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredRecords = records.filter({( Record : Record) -> Bool in
            let categoryMatch = (scope == "All") || (Record.category == scope)
            return categoryMatch && Record.fname.lowercaseString.containsString(searchText.lowercaseString) || Record.lname.lowercaseString.containsString(searchText.lowercaseString) || Record.phone.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let Result: Record
                if searchController.active && searchController.searchBar.text != "" {
                    Result = filteredRecords[indexPath.row]
                } else {
                    Result = records[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailRecord = Result
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        else if segue.identifier == "EditSegue" {
            if let destination = segue.destinationViewController as? SearchResultsViewController {
                if let orderIndex = tableView.indexPathForSelectedRow?.row {
                    destination.workidPassed = records[orderIndex].orderID
                }
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



    