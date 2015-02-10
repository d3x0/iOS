//
//  MyTableViewCell.swift
//  chatScreen2
//
//  Created by Adrian Nugraha on 2/10/15.
//  Copyright (c) 2015 d3x0 Labs. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblChat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
