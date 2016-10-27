//
//  MainNavigationController.swift
//  MessengerAppIPhone
//
//  Created by victor on 18/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class MainNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        self.navigationController?.navigationBar.barStyle = .black;//or default
        return .default //or default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.barStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)]
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
    }
}
