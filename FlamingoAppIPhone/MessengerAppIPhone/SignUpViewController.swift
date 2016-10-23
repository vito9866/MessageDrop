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
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var addAvatarButton: UIImageView!
    
    let imagePicker = UIImagePickerController()
   // @IBOutlet var singUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paddingViewUsernameTextField = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: self.usernameTextField.frame.height))
        let paddingViewEmailTextField = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: self.emailTextField.frame.height))
        let paddingViewPasswordTextField = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: self.passwordTextField.frame.height))
        
        usernameLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8/1.0)
        emailLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8/1.0)
        passwordLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8/1.0)
        
        usernameTextField.layer.cornerRadius = 20.0
        usernameTextField.clipsToBounds = true
        usernameTextField.leftView = paddingViewUsernameTextField
        usernameTextField.leftViewMode = UITextFieldViewMode.always
        
        emailTextField.layer.cornerRadius = 20.0
        emailTextField.clipsToBounds = true
        emailTextField.leftView = paddingViewEmailTextField
        emailTextField.leftViewMode = UITextFieldViewMode.always
        
        passwordTextField.layer.cornerRadius = 20.0
        passwordTextField.clipsToBounds = true
        passwordTextField.leftView = paddingViewPasswordTextField
        passwordTextField.leftViewMode = UITextFieldViewMode.always
        
        addAvatarButton.layer.cornerRadius = 42.0
        addAvatarButton.clipsToBounds = true
        
        //imagePicker.delegate = addAvatarImageView as! (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
        
        self.hideKeyboardWhenTapAround()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the filed is blank. Please, fill all fields are required.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
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
                                let dataValues: Dictionary<String, String> = ["username" : self.usernameTextField.text!, "email" : self.emailTextField.text!, "profileImageUrl" : profilePhotoUrl]
                                self.registerNewUserIntoDatabase(uid: uid, dataValues: dataValues)
                            }
                        })
                    }
                }
            })
        }
    }
    
    func registerNewUserIntoDatabase(uid: String, dataValues: [String : Any]) {
        /*FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: {
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
                let ref = FIRDatabase.database().reference(fromURL: "https://flamingomessenger-80bf4.firebaseio.com/")
                let userReference = ref.child("users").child(uid)
                let dataValues: Dictionary<String, String> = ["username" : self.usernameTextField.text!, "email" : self.emailTextField.text!, "profileImage" : metadata.downloadUrl()]
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
        })*/
        let ref = FIRDatabase.database().reference(fromURL: "https://flamingomessenger-80bf4.firebaseio.com/")
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
        FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //var selectedUserPhotoFormPhotoLibrary: UIImage?
        if let editedUserPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
            addAvatarButton.image = editedUserPhoto
            print("User photo selected")
        } else if let originalUserPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addAvatarButton.image = originalUserPhoto
            print("User photo selected")
        }
        
        /*let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
         self.addAvatarButton.image = selectedImage
         dismiss(animated: true, completion: nil)*/
        /*if let selectedUserPhoto = selectedUserPhotoFormPhotoLibrary {
            addAvatarButton.image = selectedUserPhoto
            print("User photo selected")
        }*/
        
        dismiss(animated: true, completion: nil)
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedUserPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
            addAvatarButton.image = editedUserPhoto
            print("User edited photo selected")
        } else if let originalUserPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addAvatarButton.image = originalUserPhoto
            print("User original photo selected")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectUserPhotoFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        print("Open ImagePicker")
        present(imagePickerController, animated: true, completion: nil)
    }
    
    /*private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        addAvatarButton.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }*/
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue){
    }
    
}
