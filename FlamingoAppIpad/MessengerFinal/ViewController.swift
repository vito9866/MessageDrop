//
//  ViewController.swift
//  MessengerFinal
//
//  Created by Роман Чепкий on 10.10.16.
//  Copyright © 2016 Роман Чепкий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usernameTextField: TextFieldsWithPadding!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordTextField: TextFieldsWithPadding!
    @IBOutlet var passwordLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paddingViewUsernameTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.usernameTextField.frame.height))
        let paddingViewPasswordTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.passwordTextField.frame.height))
        
        usernameTextField.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.3/1.0)
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.leftView = paddingViewUsernameTextField
        usernameTextField.leftViewMode = UITextFieldViewMode.always
        
        usernameLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5/1.0)
        
        passwordTextField.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 0.3/1.0)
        passwordTextField.layer.cornerRadius = 20
        
        passwordLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5/1.0)
        passwordTextField.leftView = paddingViewPasswordTextField
        passwordTextField.leftViewMode = UITextFieldViewMode.always

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singin(_ sender: UIButton) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proseed, because one of the field is empty. Please fil all fields are required", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"OK", style:.default, handler:nil))
            self.present(alertController, animated:true, completion: nil)
            }
        else {
            let storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let secondViewController =  storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UINavigationController
            self.present(secondViewController, animated:true, completion:  nil)
            
            
        }
    }
 @IBAction func unwindToLoginScreen(segue:UIStoryboardSegue){
    }
   }

