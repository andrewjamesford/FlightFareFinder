//
//  SettingsTableViewCell.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 11/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureWithSetting(setting: JSON) {
        let title = setting["title"].string ?? ""
        let detail = setting["detail"].string ?? ""
        
        titleLabel.text = title
        detailLabel.text = detail
        
    }
}
