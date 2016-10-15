//
//  ViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var usernameTextField: TextFieldsWithPadding!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let paddingViewUsernameTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.usernameTextField.frame.height))
        let paddingViewPasswordTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.passwordTextField.frame.height))
        

        
        // Do any additional setup after loading the view, typically from a nib.
        //usernameTextField.backgroundColor = UIColor(red: 136.0/255.0, green: 152.0/255.0, blue: 201.0/255.0, alpha: 0.3/1.0)
        usernameTextField.layer.cornerRadius = 20.0
        usernameTextField.clipsToBounds = true
        usernameTextField.leftView = paddingViewUsernameTextField
        usernameTextField.leftViewMode = UITextFieldViewMode.always
        usernameLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8/1.0)
        //passwordTextField.backgroundColor = UIColor(red: 136.0/255.0, green: 152.0/255.0, blue: 201.0/255.0, alpha: 0.3/1.0)
        passwordTextField.layer.cornerRadius = 20.0
        passwordTextField.leftView = paddingViewPasswordTextField
        passwordTextField.leftViewMode = UITextFieldViewMode.always
        passwordLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8/1.0)

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTapAround()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: UIButton) {
        /*if (usernameTextField.text == "") || (passwordTextField.text == "") {
            print("HELLO!")
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the filed is blank. Please, fill all fields are required.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
            
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "nextView") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }*/
        
        if (usernameTextField.text == "") || (passwordTextField.text == "") {
            print("HELLO!")
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the filed is blank. Please, fill all fields are required.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            FIRAuth.auth()?.createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: {
                user, error in
                if error != nil {
                    self.login()
                } else {
                    print("Uses created")
                    self.login()
                }
            })
        }
    }
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: {
            user, error in
            if error != nil {
                print("Incorrect")
                let alertController = UIAlertController(title: "Oops", message: "The entered Username or Password is wrong. Please, try again with other data.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            } else {
                print("Complete!")
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "nextView") as! UINavigationController
                self.present(controller, animated: true, completion: nil)
            }
        })
    }
    
    func hideKeyboardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }

    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
    }
}

