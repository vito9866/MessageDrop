
//
//  PeopleTableViewCell.swift
//  MessengerAppIPhone
//
//  Created by victor on 11/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet var peoplePhotoImage: UIImageView!
    @IBOutlet var peopleNameLabel: UILabel!
    @IBOutlet var textMessageLabel: UILabel!
    @IBOutlet var sentTimeLabel: UILabel!
}
