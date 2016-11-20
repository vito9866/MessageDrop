//
//  ViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class SignInViewContoller: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        tempButton.setImage(UIImage(named: "BackArrow.png"), for: .normal)
        tempButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = tempButton
        self.navigationItem.leftBarButtonItem = barButton
        
        self.navigationItem.title = "Login In"
        setupViews()
        self.hideKeyboardWhenTapAround()
    }
    
    let inputEmailTitleLabel: UILabel = {
        let inputTitle = UILabel()
        inputTitle.font = UIFont.systemFont(ofSize: 12, weight: 0.2)
        inputTitle.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        inputTitle.text = "EMAIL"
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        return inputTitle
    }()
    
    let emailInputTextField: UITextField = {
        let emailInput = UITextField()
        emailInput.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        emailInput.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        emailInput.placeholder = "Type your email"
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        return emailInput
    }()
    
    let inputPasswordTitleLabel: UILabel = {
        let inputTitle = UILabel()
        inputTitle.font = UIFont.systemFont(ofSize: 12, weight: 0.2)
        inputTitle.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        inputTitle.text = "PASSWORD"
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        return inputTitle
    }()
    
    let passwordInputTextField: UITextField = {
        let passwordInput = UITextField()
        passwordInput.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        passwordInput.isSecureTextEntry = true
        passwordInput.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        passwordInput.placeholder = "Type your password"
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        return passwordInput
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(named: "SignInButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        view.backgroundColor = UIColor.white
        
        let statusBarView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        statusBarView.backgroundColor = UIColor.clear
        view.addSubview(statusBarView)
        
        view.addSubview(inputEmailTitleLabel)
        inputEmailTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        inputEmailTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(emailInputTextField)
        emailInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailInputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailInputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailInputTextField.topAnchor.constraint(equalTo: inputEmailTitleLabel.bottomAnchor).isActive = true
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator1)
        separator1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        separator1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        separator1.topAnchor.constraint(equalTo: emailInputTextField.bottomAnchor).isActive = true
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(inputPasswordTitleLabel)
        inputPasswordTitleLabel.topAnchor.constraint(equalTo: separator1.topAnchor, constant: 15).isActive = true
        inputPasswordTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(passwordInputTextField)
        passwordInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordInputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordInputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        passwordInputTextField.topAnchor.constraint(equalTo: inputPasswordTitleLabel.bottomAnchor).isActive = true
        
        let separator2 = UIView()
        separator2.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        separator2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator2)
        separator2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        separator2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        separator2.topAnchor.constraint(equalTo: passwordInputTextField.bottomAnchor).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(signInButton)
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 30).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    func signIn(_ sender: UIButton) {
        if (emailInputTextField.text == "") || (passwordInputTextField.text == "") {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the filed is blank. Please, fill all fields are required.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            self.loginIn()
        }
    }
    
    func loginIn() {
        FIRAuth.auth()?.signIn(withEmail: emailInputTextField.text!, password: passwordInputTextField.text!, completion: {
            user, error in
            if error != nil {
                print("Incorrect")
                let alertController = UIAlertController(title: "Oops", message: "The entered Username or Password is wrong. Please, try again with other data.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            } else {
                print("Complete!")
                //let layout = UICollectionViewFlowLayout()
                //let activeConversationsListController = ActiveConversationsTableViewController(collectionViewLayout: layout)
                let mainViewController = MainViewController()
                let controller = MainNavigationController(rootViewController: mainViewController)
                controller.modalTransitionStyle = .flipHorizontal
                self.present(controller, animated: true, completion: nil)
                //self.present(activeConversationsListController, animated: true, completion: nil)
                //self.window?.rootViewController?.present(MainNavigationController(rootViewController: activeConversationsListController), animated: true, completion: nil)
            }
        })
    }
    
    func hideKeyboardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewContoller.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
}

