//
//  FiltersViewController.swift
//  Yelp
//
//  Created by William Johnson on 2/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit


@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters)
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    var businesses: [Business]!
    var categories: [[String:String]]! = []
    var sortingMethods: [[String:String]]!
    var switchStates = [Int:Bool]()
    var filters: Filters?
    var distanceExpanded: Bool = false
    var sortExpanded: Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        filters = Filters.sharedInstance
        self.categories = filters!.categories
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchBUtton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var selectedCategories = [String]()
        for (row,isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters!.selectedCategories = selectedCategories
        }
        delegate?.filtersViewController?(self, didUpdateFilters: filters!)
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        switchStates[indexPath.row] = value
    }
    // Table setup
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerInSection = UILabel()
        headerInSection.backgroundColor = UIColor.lightGrayColor()
        headerInSection.text = FilterOptions.strings[section]
        headerInSection.textAlignment = .Center
        return headerInSection
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return FilterOptions.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch FilterOptions.values[section] {
        case .Sort:
            return sortExpanded ? SortFilters.count : 1
        case .Deals:
            return 1
        case .Categories:
            return categories.count
        case .Distance:
            return distanceExpanded ? DistanceFilters.count : 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let filterType = FilterOptions.values[section]
        let row = indexPath.row
        if filterType == .Deals || filterType == .Categories {
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            if filterType == .Deals {
                cell.switchLabel.text = "Filter for deals"
                cell.onSwitch.on = filters!.deals!
            } else {
                cell.switchLabel.text = categories[row]["name"]
                cell.onSwitch.on = switchStates[row] ?? false
            }
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DropDownCell", forIndexPath: indexPath) as! DropDownCell
            if filterType == .Sort {
                if sortExpanded == true {
                    cell.dropdownLabel.text = SortFilters.strings[row]
                } else {
                    let newIndex = SortFilters.values.indexOf(filters!.sort!)
                    cell.dropdownLabel.text = SortFilters.strings[newIndex!]
                }
            }
            if filterType == .Distance {
                if distanceExpanded == true {
                    cell.dropdownLabel.text = DistanceFilters.strings[row]
                } else {
                    let newIndex = DistanceFilters.values.indexOf(filters!.distance!)
                    cell.dropdownLabel.text = DistanceFilters.strings[newIndex!]
                }
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filter = FilterOptions.strings[indexPath.section]
        let section = indexPath.section
        let row = indexPath.row
        if filter == "Deals" {
           filters!.deals! = !(filters!.deals!)
        }
        if filter == "Distance" {
            if distanceExpanded{
                filters?.distance = DistanceFilters.values[row]
            }
            distanceExpanded = !distanceExpanded
            tableView.reloadData()
            tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Fade)
        }
        if filter == "Sort" {
            if sortExpanded {
                filters?.sort = SortFilters.values[row]
            }
            sortExpanded = !sortExpanded
            tableView.reloadData()
            tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Fade)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
