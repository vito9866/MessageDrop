//
//  SignUpViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 16/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        tempButton.setImage(UIImage(named: "BackArrow.png"), for: .normal)
        tempButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = tempButton
        self.navigationItem.leftBarButtonItem = barButton
        
        navigationItem.title = "Sign Up"
        
        self.hideKeyboardWhenTapAround()
        self.setupKeyboard()
        
    }
    
    var userPhotoSelectedIndicator = false
    
    let addAvatarButton: UIImageView = {
        let imageButton = UIImageView()
        imageButton.layer.cornerRadius = 42.0
        imageButton.clipsToBounds = true
        imageButton.image = UIImage(named: "EmptyUserPhoto.png")
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.isUserInteractionEnabled = true
        return imageButton
    }()
    
    let inputUsernameTitleLabel: UILabel = {
        let inputTitle = UILabel()
        inputTitle.font = UIFont.systemFont(ofSize: 12, weight: 0.2)
        inputTitle.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        inputTitle.text = "USERNAME"
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        return inputTitle
    }()
    
    let usernameInputTextField: UITextField = {
        let usernameInput = UITextField()
        usernameInput.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        usernameInput.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        usernameInput.placeholder = "Type your username"
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        return usernameInput
    }()
    
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
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(named: "SignUpButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedUserPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
            addAvatarButton.image = editedUserPhoto
            print("User edited photo selected")
        } else if let originalUserPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addAvatarButton.image = originalUserPhoto
            print("User original photo selected")
        }
        userPhotoSelectedIndicator = true
        dismiss(animated: true, completion: nil)
    }
    
    func selectUserPhotoFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        print("Open ImagePicker")
        present(imagePickerController, animated: true, completion: nil)
    }
    
    var photoTopAnchor: NSLayoutConstraint?
    
    func setupViews() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(addAvatarButton)
        addAvatarButton.widthAnchor.constraint(equalToConstant: 84).isActive = true
        addAvatarButton.heightAnchor.constraint(equalToConstant: 84).isActive = true
        photoTopAnchor = addAvatarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30);
        photoTopAnchor?.isActive = true
        addAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(inputUsernameTitleLabel)
        inputUsernameTitleLabel.topAnchor.constraint(equalTo: addAvatarButton.bottomAnchor, constant: 30).isActive = true
        inputUsernameTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectUserPhotoFromPhotoLibrary))
        addAvatarButton.addGestureRecognizer(tap)
        
        view.addSubview(usernameInputTextField)
        usernameInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameInputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        usernameInputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        usernameInputTextField.topAnchor.constraint(equalTo: inputUsernameTitleLabel.bottomAnchor).isActive = true
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator1)
        separator1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        separator1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        separator1.topAnchor.constraint(equalTo: usernameInputTextField.bottomAnchor).isActive = true
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(inputEmailTitleLabel)
        inputEmailTitleLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 15).isActive = true
        inputEmailTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(emailInputTextField)
        emailInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailInputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailInputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailInputTextField.topAnchor.constraint(equalTo: inputEmailTitleLabel.bottomAnchor).isActive = true
        
        let separator2 = UIView()
        separator2.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        separator2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator2)
        separator2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        separator2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        separator2.topAnchor.constraint(equalTo: emailInputTextField.bottomAnchor).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(inputPasswordTitleLabel)
        inputPasswordTitleLabel.topAnchor.constraint(equalTo: separator2.topAnchor, constant: 15).isActive = true
        inputPasswordTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        view.addSubview(passwordInputTextField)
        passwordInputTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordInputTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordInputTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        passwordInputTextField.topAnchor.constraint(equalTo: inputPasswordTitleLabel.bottomAnchor).isActive = true
        
        let separator3 = UIView()
        separator3.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        separator3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator3)
        separator3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        separator3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        separator3.topAnchor.constraint(equalTo: passwordInputTextField.bottomAnchor).isActive = true
        separator3.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: separator3.bottomAnchor, constant: 30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    func signUp(_ sender: UIButton) {
        if usernameInputTextField.text == "" || emailInputTextField.text == "" || passwordInputTextField.text == "" || !userPhotoSelectedIndicator {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the filed is blank or you didn't select you photo. Please, check you data and try again.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailInputTextField.text!, password: passwordInputTextField.text! , completion: {
                user, error in
                if error != nil {
                    print("Form if not valid")
                    let alertController = UIAlertController(title: "Oops", message: "The entered Username or Password is wrong. Please, try again with other data.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                } else {
                    print("Trying to save")
                    guard let uid = user?.uid else {
                        return
                    }
                    let userPhotoName = NSUUID().uuidString
                    let storageRef = FIRStorage.storage().reference().child("userProfilePhotos").child("\(userPhotoName).png")
                    if let uploadData = UIImagePNGRepresentation(self.addAvatarButton.image!) {
                        storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                            if error != nil {
                                let alertController = UIAlertController(title: "Oops", message: "You didn't add you photo. Please, add you photo and try again.", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alertController, animated: true, completion: nil)
                                print("ProfilePhotoImage")
                                return
                            }
                            if let profilePhotoUrl: String = metadata?.downloadURL()?.absoluteString {
                                let dataValues: Dictionary<String, String> = ["username" : self.usernameInputTextField.text!, "email" : self.emailInputTextField.text!, "profileImageUrl" : profilePhotoUrl]
                                self.registerNewUserIntoDatabase(uid: uid, dataValues: dataValues)
                            }
                        })
                    }
                }
            })
        }
    }
    
    func registerNewUserIntoDatabase(uid: String, dataValues: [String : Any]) {
        let ref = FIRDatabase.database().reference()
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(dataValues, withCompletionBlock: {
            err, ref in
            if err != nil {
                print("Failed save to server database")
                return
            }
            print("Succesfully saved to server databse")
        })
        self.loginIn()
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
            }
        })
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func showKeyboard(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        photoTopAnchor?.constant = -90
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideKeyboard(notification: NSNotification) {
        photoTopAnchor?.constant = 30
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideKeyboardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        self.view?.addGestureRecognizer(tap)
    }
    
    /*func hideKeyboardWhenTapAround() {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewContoller.dismissKeyboardView))
     tap.cancelsTouchesInView = false
     view.addGestureRecognizer(tap)
     }*/
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
