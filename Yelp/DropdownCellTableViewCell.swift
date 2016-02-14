//
//  DropdownCellTableViewCell.swift
//  Yelp
//
//  Created by William Johnson on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DropdownCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropDownImage.image = UIImage(named: "drop")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
