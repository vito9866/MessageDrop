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
    var imageUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    
    func conversationPartnerId() -> String? {
        return fromUid == FIRAuth.auth()?.currentUser?.uid ? toUid : fromUid
    }
    
    init(dictionary: [String : Any]) {
        fromUid = dictionary["fromUid"] as? String
        text = dictionary["text"] as? String
        time = dictionary["time"] as? String
        toUid = dictionary["toUid"] as? String
        
        imageUrl = dictionary["imageUrl"] as? String
        imageWidth = dictionary["imageWidth"] as? NSNumber
        imageHeight = dictionary["imageHeight"] as? NSNumber
    }
}


