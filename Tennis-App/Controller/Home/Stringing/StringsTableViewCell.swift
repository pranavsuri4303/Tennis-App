//
//  StringsTableViewCell.swift
//  Tennis-App
//
//  Created by Appletree on 16/05/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit

class StringsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRacket: UILabel!
    @IBOutlet weak var lblStringBrand: UILabel!
    @IBOutlet weak var lblStringName: UILabel!
    @IBOutlet weak var lblCrossTension: UILabel!
    @IBOutlet weak var lblMainTension: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


