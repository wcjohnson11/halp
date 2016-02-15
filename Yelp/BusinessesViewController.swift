//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FiltersViewControllerDelegate {

    var businesses: [Business]!
    var searchActive: Bool = false
    var filteredBusinesses: [Business]!
    var filters: Filters?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredBusinesses = businesses
        
        configureTableView()
        configureSearchBar()
        definesPresentationContext = true


        Business.searchWithTerm("Restaurants", distance: nil, sort: .Distance, categories: [], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Update Logic
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBusinesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = filteredBusinesses[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    // Update the table based on Filter Selections
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters) {
        let categories = filters.selectedCategories
        let deals = filters.deals
        let distance = filters.getDistance()
        let sort = YelpSortMode(rawValue: filters.getSortMode())
        
        Business.searchWithTerm("Restaurants", distance: distance, sort: sort, categories: categories, deals: deals) {
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter({(business: Business) -> Bool in
            return business.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        tableView.reloadData()
    }
    
    func configureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Halp!"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }


    // MARK: - Navigation

    // Prepare for segue to filterView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }

}
