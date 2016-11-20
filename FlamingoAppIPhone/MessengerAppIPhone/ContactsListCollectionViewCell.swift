//
//  ContactListCollectionViewCell.swift
//  MessengerAppIPhone
//
//  Created by victor on 28/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class ContactsListCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 0.05/1.0) : UIColor.white
        }
    }
    
    let userImagePhoto: UIImageView = {
        let userPhoto = UIImageView()
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.cornerRadius = 25.0
        userPhoto.image = UIImage(named: "EmptyUserPhotoList.png")
        userPhoto.clipsToBounds = true
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        return userPhoto
    }()
    
    let userNameLabel: UILabel = {
        let userName = UILabel()
        userName.text = "Hello World"
        userName.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        userName.font = UIFont.systemFont(ofSize: 15, weight: 0.2)
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    let userEmailLabel : UILabel = {
        let userEmail = UILabel()
        userEmail.text = "Hello World"
        userEmail.textColor = UIColor(red: 143.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0/1.0)
        userEmail.font = UIFont.systemFont(ofSize: 14, weight: 0)
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        return userEmail
    }()
    
    func setupView() {
        backgroundColor = UIColor.white
        
        addSubview(userImagePhoto)
        userImagePhoto.widthAnchor.constraint(equalToConstant: 53).isActive = true
        userImagePhoto.heightAnchor.constraint(equalToConstant: 53).isActive = true
        userImagePhoto.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        userImagePhoto.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: userImagePhoto.rightAnchor, constant: 15).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        
        containerView.addSubview(userEmailLabel)
        userEmailLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        userEmailLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(red: 215.0/255.0, green: 219.0/255.0, blue: 227.0/255.0, alpha: 1.0/1.0)
        addSubview(separatorLine)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }

}
