//
//  UserCollectionViewCell.swift
//  MessengerAppIPhone
//
//  Created by victor on 28/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class ActiveConversationsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 238.0/255.0, green: 242.0/255.0, blue: 248.0/255.0, alpha: 1.0/1.0) : UIColor.white
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
    
    let sentTimeLabel: UILabel = {
        let sentTime = UILabel()
        sentTime.text = "09:41"
        sentTime.textColor = UIColor(red: 143.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0/1.0)
        sentTime.font = UIFont.systemFont(ofSize: 12, weight: 0.1)
        sentTime.translatesAutoresizingMaskIntoConstraints = false
        return sentTime
    }()
    
    let shortMessageLabel: UILabel = {
        let shortMessage = UILabel()
        shortMessage.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
        shortMessage.textColor = UIColor(red: 143.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0/1.0)
        shortMessage.font = UIFont.systemFont(ofSize: 14, weight: 0)
        shortMessage.translatesAutoresizingMaskIntoConstraints = false
        return shortMessage
    }()
    
    func setupView() {
        backgroundColor = UIColor.white
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        addSubview(userImagePhoto)
        userImagePhoto.heightAnchor.constraint(equalToConstant: 53).isActive = true
        userImagePhoto.widthAnchor.constraint(equalToConstant: 53).isActive = true
        userImagePhoto.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImagePhoto.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 83).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        containerView.addSubview(userNameLabel)
        userNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        containerView.addSubview(sentTimeLabel)
        sentTimeLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        sentTimeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
        containerView.addSubview(shortMessageLabel)
        shortMessageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        shortMessageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        shortMessageLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        shortMessageLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
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
