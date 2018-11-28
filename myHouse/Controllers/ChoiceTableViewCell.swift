//
//  ChoiceTableViewCell.swift
//  myHouse
//
//  Created by Romain SERCER on 23/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var switchButton: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if Application.advancedMode == false {
            switchButton.isOn = false
        } else {
            switchButton.isOn = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
