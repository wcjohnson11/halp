//
//  DropDownCell.swift
//  Yelp
//
//  Created by William Johnson on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownLabel: UILabel!
    @IBOutlet weak var dropdownImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropdownImage.image = UIImage(named: "arrow")
        self.selectionStyle = UITableViewCellSelectionStyle.None
        dropdownView.layer.cornerRadius = 3
        dropdownView.layer.masksToBounds = true
        dropdownView.layer.borderWidth = 1
        dropdownView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
