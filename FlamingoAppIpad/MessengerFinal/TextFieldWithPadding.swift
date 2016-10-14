//
//  TextFieldWithPadding.swift
//  MessengerFinal
///Users/roman/Documents/Programming/MessengerFinal/MessengerFinal/TextFieldWithPadding.swift
//  Created by Роман Чепкий on 10.10.16.
//  Copyright © 2016 Роман Чепкий. All rights reserved.
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
