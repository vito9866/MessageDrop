//
//  ConversationLog.swift
//  MessengerAppIPhone
//
//  Created by victor on 23/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase
import QuartzCore

class ConversationLogCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var navigationBarBackButtonTitle = ""
    
    var user = User() {
        didSet {
            lookingMessages()
        }
    }
    
    var messagesList = [MessageWrapper]()
    
    lazy var inputMessageTextField: UITextField = {
        let inputMessageTextField = UITextField()
        let placeholder = NSAttributedString(string: "Type something...", attributes: [NSForegroundColorAttributeName : UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)])
        //inputMessageTextField.placeholder = "Type something..."
        inputMessageTextField.attributedPlaceholder = placeholder
        inputMessageTextField.translatesAutoresizingMaskIntoConstraints = false
        inputMessageTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        //inputMessageTextField.font = UIFont.systemFont(ofSize: 15)
        inputMessageTextField.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        inputMessageTextField.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        inputMessageTextField.layer.cornerRadius = 15.0
        inputMessageTextField.delegate = self
        return inputMessageTextField
    }()
    
    /*override func viewDidLayoutSubviews() {
        let section = 0
        let lastItemIndex = self.dateCollectionView.numberOfItemsInSection(section) - 1
        let indexPath:NSIndexPath = NSIndexPath.init(forItem: lastItemIndex, inSection: section)
        self.dateCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: false)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paddingViewInputMessageTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.inputMessageTextField.frame.height))
        inputMessageTextField.leftView = paddingViewInputMessageTextField
        inputMessageTextField.leftViewMode = UITextFieldViewMode.always
        
        self.navigationItem.title = navigationBarBackButtonTitle
        self.navigationController!.navigationBar.tintColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 60, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        self.collectionView?.backgroundColor = UIColor(red: 236.0/255.0, green: 238.0/255.0, blue: 239.0/255.0, alpha: 1.0/1.0)
        navigationItem.title = user.username
        collectionView?.register(ConversationLogCell.self, forCellWithReuseIdentifier: "cellId")
        
        setupInputComponents()
        setupKeyboard()
        
        inputMessageTextField.delegate = self
        self.hideKeyboardWhenTapAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ConversationLogCell
        let wrapperWidth = calculationFrameForTextMessage(textMessage: messagesList[indexPath.row].text!).width + 50
        //cell.gradientLayer.frame = CGRect(x: 0, y: 0, width: wrapperWidth, height: wrapperHeight)
        cell.textViewMessage.text = messagesList[indexPath.row].text
        cell.textViewMessage.isUserInteractionEnabled = false
        cell.textViewTime.isUserInteractionEnabled = false
        if let seconds = Double(messagesList[indexPath.row].time! as String) {
            let sentTimeDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.textViewTime.text = dateFormatter.string(from: sentTimeDate as Date)
        }
        //cell.textViewTime.scrollsToTop = false
        cell.textViewTime.scrollRangeToVisible(NSRange(location:0, length:0))
        //collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
        cell.wrapperWidthAnchor?.constant = wrapperWidth
        if messagesList[indexPath.row].fromUid == FIRAuth.auth()?.currentUser?.uid {
            //cell.gradientLayer.colors = [UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 1.0/1.0).cgColor, UIColor(red: 109.0/255.0, green: 148.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0).cgColor]
            cell.wrapperView.backgroundColor = UIColor(red: 72.0/255.0, green: 83.0/255.0, blue: 125.0/255.0, alpha: 255.0/255.0)
            cell.textViewMessage.textColor = UIColor.white
            cell.wrapperRightAnchor?.isActive = true
            cell.wrapperLeftAnchor?.isActive = false
        } else {
            //cell.gradientLayer.colors = [UIColor(red: 178.0/255.0, green: 194.0/255.0, blue: 210.0/255.0, alpha: 1.0/1.0).cgColor, UIColor(red: 223.0/255.0, green: 233.0/255.0, blue: 242.0/255.0, alpha: 1.0/1.0).cgColor]
            cell.wrapperView.backgroundColor = UIColor.white
            cell.textViewMessage.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
            cell.wrapperRightAnchor?.isActive = false
            cell.wrapperLeftAnchor?.isActive = true
        }
        //self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var wrapperHeight: CGFloat = 80
        
        
        if let text = messagesList[indexPath.row].text {
            wrapperHeight = calculationFrameForTextMessage(textMessage: text).height + 40
        }
        
        return CGSize(width: view.frame.width, height: wrapperHeight)
    }
    
    func calculationFrameForTextMessage(textMessage: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: textMessage).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)], context: nil)
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("", for: .normal)
        sendButton.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        sendButton.tintColor = UIColor(red: 72.0/255.0, green: 83.0/255.0, blue: 125.0/255.0, alpha: 255.0/255.0)
        sendButton.setImage(UIImage(named: "SendButton1"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        //sendButton.backgroundColor = UIColor(red:  255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        containerView.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        containerView.addSubview(inputMessageTextField)
        inputMessageTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputMessageTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputMessageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        //inputMessageTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        inputMessageTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let separatorTopLine = UIView()
        separatorTopLine.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.2/1.0)
        separatorTopLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorTopLine)
        separatorTopLine.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorTopLine.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorTopLine.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorTopLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func sendMessage() {
        let reference = FIRDatabase.database().reference().child("messages")
        let childReference = reference.childByAutoId()
        let sentTime = Int(NSDate().timeIntervalSince1970)
        let values = ["text" : inputMessageTextField.text!, "toUid" : user.uid!, "fromUid" : FIRAuth.auth()!.currentUser!.uid, "time" : String(sentTime)]
        childReference .updateChildValues(values)
        print(inputMessageTextField.text)
        childReference.updateChildValues(values) { (error, reference) in
            if error != nil {
                print("Error send message")
                return
            }
            self.inputMessageTextField.text = nil
            let userMessegesReference = FIRDatabase.database().reference().child("userMessages").child((FIRAuth.auth()?.currentUser?.uid)!)
            let messageId = childReference.key
            userMessegesReference.updateChildValues([messageId : 1])
            
            let recipientUserMessegesReference = FIRDatabase.database().reference().child("userMessages").child(self.user.uid!)
            recipientUserMessegesReference.updateChildValues([messageId : 1])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    func lookingMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let userMessagesReference = FIRDatabase.database().reference().child("userMessages").child(uid)
        userMessagesReference.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messagesReference = FIRDatabase.database().reference().child("messages").child(messageId)
            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String : Any] else {
                    return
                }
                let message = MessageWrapper()
                message.setValuesForKeys(dictionary)
                
                let conversationPartnerUid: String
                if message.fromUid == FIRAuth.auth()?.currentUser?.uid {
                    conversationPartnerUid = message.toUid!
                } else {
                    conversationPartnerUid = message.fromUid!
                }
                
                if conversationPartnerUid == self.user.uid {
                    self.messagesList.append(message)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
                }, withCancel: nil)
            }, withCancel: nil)
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func showKeyboard(notification: NSNotification) {
        //let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).rect
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //print(keyboardFrame.height)
        containerViewBottomAnchor?.constant = -keyboardFrame.height
        UIView.animate(withDuration: keyboardDuration) { 
            self.view.layoutIfNeeded()  
        }
    }
    
    func hideKeyboard(notification: NSNotification) {
        containerViewBottomAnchor?.constant = 0
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }

    }
    
    func hideKeyboardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
}
