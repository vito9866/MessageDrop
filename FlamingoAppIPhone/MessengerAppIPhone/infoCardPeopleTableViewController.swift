//
//  infoCardPeopleTableViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 11/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class infoCardPeopleTableViewController {
    var peoplePhotoImage = ""
    var peopleName = ""
    var peopleMessageText = ""
    var sentTime = ""
    
    init(peoplePhotoImage: String, peopleName: String, peopleMessageText: String, sentTime: String) {
        self.peopleName = peopleName
        self.peoplePhotoImage = peoplePhotoImage
        self.peopleMessageText = peopleMessageText
        self.sentTime = sentTime
    }
}
