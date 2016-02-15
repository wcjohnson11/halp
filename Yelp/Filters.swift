//
//  Filters.swift
//  Yelp
//
//  Created by William Johnson on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

enum FilterOptions: String {
    case Categories = "Categories"
    case Deals = "Deals"
    case Distance = "Distance"
    case Sort = "Sort"
    
    static let count = 4
    static let strings = ["Sort","Deals","Distance","Categories"]
    static let values = [Sort, Deals, Distance, Categories]
}

enum CategoryFilters {
    static let strings = [
        ["name" : "American, New", "code": "newamerican"],
        ["name" : "American, Traditional", "code": "tradamerican"],
        ["name" : "Asian Fusion", "code": "asianfusion"],
        ["name" : "Barbeque", "code": "bbq"],
        ["name" : "Basque", "code": "basque"],
        ["name" : "Beer Garden", "code": "beergarden"],
        ["name" : "Beer Hall", "code": "beerhall"],
        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
        ["name" : "Chinese", "code": "chinese"],
        ["name" : "Dumplings", "code": "dumplings"],
        ["name" : "Filipino", "code": "filipino"],
        ["name" : "Japanese", "code": "japanese"],
        ["name" : "Korean", "code": "korean"]
    ]

}

enum DistanceFilters:  Int {
    case Auto = 0
    case One = 1609
    case Five = 8045
    case Twenty = 32180
    
    static let count = 3
    static let strings = ["Auto", "1 Mile", "5 Miles", "20 Miles"]
    static let values = [Auto, One, Five, Twenty]
}

enum SortFilters: Int {
    case BestMatch = 0
    case Distance = 1
    case HighestRated = 2
    
    static let count = 3
    static let strings = ["Best Match", "Distance", "Highest Rated"]
    static let values = [BestMatch, Distance, HighestRated]
}

class Filters: NSObject {
    var categories: [[String: String]]?
    var deals: Bool?
    var distance: DistanceFilters?
    var sort: SortFilters?
    var state: NSDictionary?
    var selectedCategories: [String]?
    
    override init() {
        categories = CategoryFilters.strings
        deals = false
        sort = .BestMatch
        distance = .Auto
    }
    func getSortMode() -> Int {
        return SortFilters.values.indexOf(self.sort!)!
    }
    
    func getDistance() -> Int {
        return DistanceFilters.values.indexOf(self.distance!)!
    }
}
