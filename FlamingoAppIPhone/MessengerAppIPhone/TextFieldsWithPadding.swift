//
//  TextFieldsWithPadding.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class TextFieldsWithPadding: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
