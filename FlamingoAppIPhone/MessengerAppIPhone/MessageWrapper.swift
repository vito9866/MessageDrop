//
//  MessageWrapper.swift
//  MessengerAppIPhone
//
//  Created by victor on 23/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class MessageWrapper: NSObject {
    var fromUid: String?
    var text: String?
    var time: String?
    var toUid: String?
    
    func conversationPartnerId() -> String? {
        return fromUid == FIRAuth.auth()?.currentUser?.uid ? toUid : fromUid
    }
}


