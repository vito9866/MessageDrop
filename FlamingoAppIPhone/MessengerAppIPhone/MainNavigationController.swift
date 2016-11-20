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
        self.navigationController?.navigationBar.barStyle = .black;
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setNeedsStatusBarAppearanceUpdate()
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
        navigationBar.isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackArrow.png"), style: .plain, target: self, action: nil)
        //UINavigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0
    }
    
}
