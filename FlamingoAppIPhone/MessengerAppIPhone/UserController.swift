//
//  UserController.swift
//  MessengerAppIPhone
//
//  Created by victor on 13/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import Foundation

class UserController {
    var messageText = ""
    var otherUserSender = true
    
    init(messageText: String, otherUserSender: Bool) {
        self.messageText = messageText
        self.otherUserSender = otherUserSender
    }
}
