//
//  ConversationLog.swift
//  MessengerAppIPhone
//
//  Created by victor on 23/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ConversationLogCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //let containerNoMessages = UIView()
    let noMessagesLabel: UILabel = {
        let label = UILabel()
        label.text = "No messages"
        label.textColor = UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 199.0/255.0, alpha: 1.0/1.0)
        label.font = UIFont.systemFont(ofSize: 15, weight: 0.2)
        return label
    }()
    
    var navigationBarBackButtonTitle = ""
    
    var user = User() {
        didSet {
            lookingMessages()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var messagesList = [MessageWrapper]()
    var haveMessagesInd = true
    
    lazy var inputMessageTextField: UITextField = {
        let inputMessageTextField = UITextField()
        let placeholder = NSAttributedString(string: "Type something...", attributes: [NSForegroundColorAttributeName : UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)])
        inputMessageTextField.attributedPlaceholder = placeholder
        inputMessageTextField.translatesAutoresizingMaskIntoConstraints = false
        inputMessageTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0/1.0)
        inputMessageTextField.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        inputMessageTextField.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        inputMessageTextField.layer.cornerRadius = 15.0
        inputMessageTextField.delegate = self
        return inputMessageTextField
    }()
    
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackArrow.png"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector(dismissConversationViewController))
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "CloseButton.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(dismissConversationViewController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let paddingViewInputMessageTextField = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.inputMessageTextField.frame.height))
        inputMessageTextField.leftView = paddingViewInputMessageTextField
        inputMessageTextField.leftViewMode = UITextFieldViewMode.always
        
        //self.navigationController!.navigationBar.tintColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.alwaysBounceVertical = true
        self.collectionView?.backgroundColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0/1.0)
        navigationItem.title = user.username
        collectionView?.register(ConversationLogCell.self, forCellWithReuseIdentifier: "cellId")
        
        setupInputComponents()
        setupKeyboard()
        
        inputMessageTextField.delegate = self
        self.hideKeyboardWhenTapAround()
        
       // addNoMessagesAlert()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if messagesList.count == 0 {
            addNoMessagesAlert()
        }
        return messagesList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        noMessagesLabel.removeFromSuperview()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ConversationLogCell
        if let messageText = messagesList[indexPath.row].text {
            cell.wrapperWidthAnchor?.constant = calculationFrameForTextMessage(textMessage: messageText).width + 50
            cell.imageViewMessage.isHidden = true
        } else if messagesList[indexPath.row].imageUrl != nil {
            cell.wrapperWidthAnchor?.constant = 220
            cell.imageViewMessage.isHidden = false
        }
        
        cell.conversationLogCollectionViewController = self
        
        //let wrapperWidth = calculationFrameForTextMessage(textMessage: messagesList[indexPath.row].text!).width + 50
        cell.textViewMessage.text = messagesList[indexPath.row].text
        cell.textViewMessage.isUserInteractionEnabled = false
        if let seconds = Double(messagesList[indexPath.row].time!) {
            let sentTimeDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.timeLabel.text = dateFormatter.string(from: sentTimeDate as Date)
        }
        //cell.wrapperWidthAnchor?.constant = wrapperWidth
        
        if messagesList[indexPath.row].fromUid == FIRAuth.auth()?.currentUser?.uid {
            cell.wrapperView.backgroundColor = UIColor(red: 254.0/255.0, green: 215.0/255.0, blue: 230.0/255.0, alpha: 1.0/1.0)
            cell.wrapperView.layer.borderWidth = 1.0
            cell.wrapperView.layer.borderColor = (UIColor(red: 254.0/255.0, green: 183.0/255.0, blue: 210.0/255.0, alpha: 1.0/1.0)).cgColor
            cell.timeLabel.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 0.5/1.0)
            cell.wrapperRightAnchor?.isActive = true
            cell.wrapperLeftAnchor?.isActive = false
        } else {
            cell.wrapperView.backgroundColor = UIColor.white
            cell.wrapperView.layer.borderWidth = 1.0
            cell.wrapperView.layer.borderColor = (UIColor(red: 220.0/255.0, green: 218.0/255.0, blue: 226.0/255.0, alpha: 1.0/1.0)).cgColor
            cell.timeLabel.textColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)
            cell.wrapperRightAnchor?.isActive = false
            cell.wrapperLeftAnchor?.isActive = true
        }
        
        if let messageUrl = messagesList[indexPath.row].imageUrl {
            cell.imageViewMessage.loadImagesUsingCacheMemoryWithUrlString(urlString: messageUrl)
            cell.wrapperView.backgroundColor = UIColor.clear
            cell.timeLabel.textColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var wrapperHeight: CGFloat = 80
        if let text = messagesList[indexPath.row].text {
            wrapperHeight = calculationFrameForTextMessage(textMessage: text).height + 36
        } else if let imageWidth = messagesList[indexPath.row].imageWidth?.floatValue, let imageHeight = messagesList[indexPath.row].imageHeight?.floatValue {
            wrapperHeight = CGFloat(imageHeight * 200 / imageWidth)
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
        sendButton.tintColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
        sendButton.setImage(UIImage(named: "SendButton.png"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        let addImageButton: UIButton = {
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
            //button.backgroundColor = UIColor.red
            button.tintColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
            button.setImage(UIImage(named: "AddImageButton.png"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
            return button
        }()
        containerView.addSubview(addImageButton)
        addImageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 13).isActive = true
        addImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        addImageButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        addImageButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputMessageTextField)
        inputMessageTextField.leftAnchor.constraint(equalTo: addImageButton.rightAnchor, constant: 5).isActive = true
        inputMessageTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputMessageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
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
        if self.inputMessageTextField.text != "" {
            let reference = FIRDatabase.database().reference().child("messages")
            let childReference = reference.childByAutoId()
            let sentTime = Int(NSDate().timeIntervalSince1970)
            let values = ["text" : inputMessageTextField.text!, "toUid" : user.uid!, "fromUid" : FIRAuth.auth()!.currentUser!.uid, "time" : String(sentTime)]
            childReference.updateChildValues(values)
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
                let message = MessageWrapper(dictionary: dictionary)
                //message.setValuesForKeys(dictionary)
                
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
                        let indexPath = NSIndexPath(item: self.messagesList.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
                    }
                }
                }, withCancel: nil)
            }, withCancel: nil)
    }
    
    func addNoMessagesLabel() {
        let noMessageLabel = UILabel()
        noMessageLabel.text = "No messages"
        noMessageLabel.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        noMessageLabel.backgroundColor = UIColor.clear
        noMessageLabel.font = UIFont.systemFont(ofSize: 15, weight: 0.2)
        noMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noMessageLabel)
        noMessageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noMessageLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        noMessageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        noMessageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func openImagePicker() {
        print("Open Image Picker")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Image selected")
        
        var selectedImage: UIImage?
        
        if let editedUserPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = editedUserPhoto
            print("User edited photo selected")
        } else if let originalUserPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = originalUserPhoto
            print("User original photo selected")
        }
        
        if let image = selectedImage {
            uploadImageToServer(image: image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToServer(image: UIImage) {
        print("Upload to server")
        let imageName = NSUUID().uuidString
        let reference = FIRStorage.storage().reference().child("messagesPhotos").child(imageName)
        if let uploadImage = UIImageJPEGRepresentation(image, 0.5) {
            reference.put(uploadImage, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("Error upload image")
                    return
                }
                
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    self.sendMessageWithImage(imageUrl: imageUrl, image: image)
                }
                
            })
        }
    }
    
    func sendMessageWithImage(imageUrl: String, image: UIImage) {
        let reference = FIRDatabase.database().reference().child("messages")
        let childReference = reference.childByAutoId()
        let sentTime = Int(NSDate().timeIntervalSince1970)
        let values = ["toUid" : user.uid!, "fromUid" : FIRAuth.auth()!.currentUser!.uid, "time" : String(sentTime), "imageUrl" : imageUrl, "imageWidth": image.size.width, "imageHeight": image.size.height] as [String : Any]
        childReference.updateChildValues(values)
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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    var firstFrame: CGRect?
    var viewBackground: UIView?
    var startImageView: UIImageView?
    
    func performFullScreenForImageView(imageView: UIImageView) {
        
        self.startImageView = imageView
        self.startImageView?.isHidden = true
        
        self.firstFrame = imageView.superview?.convert(imageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: firstFrame!)
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeImage)))
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.image = imageView.image
        if let keyWindow = UIApplication.shared.keyWindow {
            viewBackground = UIView(frame: keyWindow.frame)
            viewBackground?.backgroundColor = UIColor.black
            viewBackground?.alpha = 0.0
            keyWindow.addSubview(viewBackground!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.viewBackground?.alpha = 1.0
                let imageHeight = (self.firstFrame?.height)! / (self.firstFrame?.width)! * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: imageHeight)
                zoomingImageView.center = keyWindow.center
            }, completion: nil)
            
            /*UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.viewBackground?.alpha = 1.0
                let imageHeight = (self.firstFrame?.height)! / (self.firstFrame?.width)! * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: imageHeight)
                zoomingImageView.center = keyWindow.center
            }, completion: nil)*/
        }
    }
    
    func closeImage(tapGesture: UITapGestureRecognizer) {
        if let zoomOutImageView = tapGesture.view {
            zoomOutImageView.layer.cornerRadius = 10.0
            zoomOutImageView.clipsToBounds = true
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.firstFrame!
                self.viewBackground?.alpha = 0.0
            }, completion: { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
                self.startImageView?.isHidden = false
            })
            
        }
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func showKeyboard(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        containerViewBottomAnchor?.constant = -keyboardFrame.height
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.async {
            let indexPath = NSIndexPath(item: self.messagesList.count - 1, section: 0)
            self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardView))
        tap.cancelsTouchesInView = false
        self.collectionView?.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func dismissConversationViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func addNoMessagesAlert() {

        view.addSubview(noMessagesLabel)
        noMessagesLabel.translatesAutoresizingMaskIntoConstraints = false
        noMessagesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noMessagesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
}
