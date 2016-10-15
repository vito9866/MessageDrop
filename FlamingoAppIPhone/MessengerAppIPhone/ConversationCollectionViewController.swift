//
//  ConversationViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 11/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class ConversationCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var userName = ""
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 0.9/1.0)
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    let color11 = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 1.0/1.0)
    let color12 = UIColor(red: 109.0/255.0, green: 148.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0)
    let color21 = UIColor(red: 223.0/255.0, green: 233.0/255.0, blue: 242.0/255.0, alpha: 0.98/1.0)
    let color22 = UIColor(red: 178.0/255.0, green: 194.0/255.0, blue: 210.0/255.0, alpha: 1.0/1.0)
    
    var messagesBase = [
        UserController(messageText: "This car so beautiful.", otherUserSender: false),
        UserController(messageText: "Yeah, all right!", otherUserSender: true),
        UserController(messageText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", otherUserSender: false),
        UserController(messageText: "Really!", otherUserSender: false),
        UserController(messageText: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", otherUserSender: true),
        UserController(messageText: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.", otherUserSender: false),
        UserController(messageText: "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.", otherUserSender: true)
    ]
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationItem.title = "Conversations"
        //self.navigationController?.navigationBar.topItem?.title = "Conversations"
        //self.navigationController?.navigationBar.topItem?.title = "Conversations";
        //self.navigationItem.title = "Conversations";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ConversationCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationItem.title = userName
        self.navigationController!.navigationBar.tintColor = UIColor.white
        //self.navigationItem.backBarButtonItem?.title = ""
        //self.navigationController?.navigationBar.topItem?.title = "";
        //self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
        view.addConstraintsWithFormat(format: "V:[v0(48)]", views: messageInputContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        setupInputComponents()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let amount: Int = messagesBase.count {
            return amount
        }
        return 0
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ConversationCollectionViewCell
        if let messageText: String = messagesBase[indexPath.item].messageText {
            cell.messageTextView.text = messageText
            let size = CGSize(width: 225, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil)
            if messagesBase[indexPath.item].otherUserSender {
                cell.messageTextView.frame = CGRect(x: 16, y: 0, width: estimatedFrame.width + 21, height: estimatedFrame.height + 25)
                cell.messageTextView.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
                cell.textBubbleView.frame = CGRect(x: 16 - 10, y: -3, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
                cell.textBubbleView.backgroundColor = color22
            } else {
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 8 - 16 - 8, y: 0, width: estimatedFrame.width + 25, height: estimatedFrame.height + 25)
                cell.messageTextView.textColor = UIColor.white
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 8 - 8 - 16 - 10, y: -3, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                cell.textBubbleView.backgroundColor = color11
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText: String = messagesBase[indexPath.item].messageText {
            let size = CGSize(width: 225, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 25)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
        
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
    }
    
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

