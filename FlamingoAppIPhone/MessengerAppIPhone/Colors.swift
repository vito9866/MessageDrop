//
//  Colors.swift
//  MessengerAppIPhone
//
//  Created by victor on 25/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class Colors {
    let colorTop = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 1.0/1.0)
    let colorBottom = UIColor(red: 109.0/255.0, green: 148.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0)
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
