//
//  infoCardPeopleTableViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 11/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class InfoCardPeopleTableViewController {
    var profilePhotoImage = ""
    var peopleName = ""
    var peopleMessageText = ""
    var sentTime = ""
    
    init(peoplePhotoImage: String, peopleName: String, peopleMessageText: String, sentTime: String) {
        self.peopleName = peopleName
        self.profilePhotoImage = peoplePhotoImage
        self.peopleMessageText = peopleMessageText
        self.sentTime = sentTime
    }
    
    init(peopleName: String, profilePhotoImage: String) {
        self.peopleName = peopleName
        //self.peoplePhotoImage = "EmptyAvatarList"
        self.profilePhotoImage = profilePhotoImage
        self.peopleMessageText = "Some message"
        self.sentTime = "00:00"
    }
    
    init(peopleName: String) {
        self.peopleName = peopleName
        //self.peoplePhotoImage = "EmptyAvatarList"
        self.profilePhotoImage = ""
        self.peopleMessageText = "Some message"
        self.sentTime = "00:00"
    }

    
}
