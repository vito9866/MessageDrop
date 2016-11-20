//
//  ProfileViewController.swift
//  MessengerAppIPhone
//
//  Created by Victor Macintosh on 15/11/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    var profilePhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 60.0
        image.clipsToBounds = true
        return image
    }()
    
    var profileName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        name.font = UIFont.systemFont(ofSize: 20, weight: 0.2)
        name.textAlignment = .center
        name.text = "Erlich Bachman"
        return name
    }()
    
    var profileEmail: UILabel = {
        let email = UILabel()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = UIColor(red: 143.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0/1.0)
        email.font = UIFont.systemFont(ofSize: 15, weight: 0)
        email.text = "bachman@flamingo.com"
        email.textAlignment = .center
        return email
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "EditProfileButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SignOutButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        loadUserData()
        
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        containerView.addSubview(profilePhoto)
        profilePhoto.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profilePhoto.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        profilePhoto.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profilePhoto.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        containerView.addSubview(profileName)
        profileName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileName.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 25).isActive = true
        profileName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        profileName.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        containerView.addSubview(profileEmail)
        profileEmail.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileEmail.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 10).isActive = true
        profileEmail.heightAnchor.constraint(equalToConstant: 18).isActive = true
        profileEmail.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        /*containerView.addSubview(signOutButton)
        signOutButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        signOutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signOutButton.addTarget(self, action: #selector(logoutProfile), for: .touchUpInside)*/
        
        view.addSubview(signOutButton)
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signOutButton.addTarget(self, action: #selector(logoutProfile), for: .touchUpInside)
        
        view.addSubview(editProfileButton)
        editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editProfileButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -15).isActive = true
        editProfileButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        editProfileButton.addTarget(self, action: #selector(logoutProfile), for: .touchUpInside)
        
        
    }
    
    func loadUserData() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String : Any] {
                if let profileImageUrl: String = dictionary["profileImageUrl"] as! String? {
                    self.profilePhoto.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
                }
                
                self.profileName.text = dictionary["username"] as? String
                self.profileEmail.text = dictionary["email"] as? String
            }
        }, withCancel: nil)
    }
    
    func logoutProfile() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let controller = WelcomeViewController()
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
}
