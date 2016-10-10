//
//  ViewController.swift
//  FlamingoAppMac
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController {
    
    @IBOutlet var usernameTextField: NSTextField!
    @IBOutlet var passwordTextField: NSTextField!
    
    @IBOutlet weak var mainViewController: NSView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //usernameTextField.layer?.backgroundColor = CGColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.3/1.0)
        usernameTextField.layer?.cornerRadius = 15.0
        //passwordTextField.layer?.backgroundColor = CGColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.3/1.0)
        passwordTextField.layer?.cornerRadius = 15.0
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }



}

