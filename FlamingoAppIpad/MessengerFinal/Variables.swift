//
//  Variables.swift
//  MessengerFinal
//


import UIKit

class infoCardPeopleTableViewController{
    var peoplePhotoImage = ""
    var peopleName = ""
    var peopleMessageText = ""
    var sentTime = ""
    
    init(peoplePhotoImage: String, peopleName:String, peopleMessageText: String, sentTime: String){
        self.peoplePhotoImage = peoplePhotoImage
        self.peopleName = peopleName
        self.peopleMessageText = peopleMessageText
        self.sentTime = sentTime
        
    }
    
}
