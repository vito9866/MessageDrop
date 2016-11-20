//
//  ChatsViewController.swift
//  MessengerAppIPhone
//
//  Created by Victor Macintosh on 15/11/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ChatsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var lastContentOffset: CGFloat = 0.0
    
    var messagesList = [MessageWrapper]()
    var conversationDictionary = [String : MessageWrapper]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        collectionView?.register(ActiveConversationsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupViews()
    }
    
    func setupViews() {
        
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.collectionView?.backgroundColor = UIColor.white
        //self.collectionView?.alwaysBounceVertical = true
        checkIsUserLogIn()
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of the users: \(messagesList.count)")
        return messagesList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActiveConversationsCollectionViewCell
        
        cell.preservesSuperviewLayoutMargins = false
        
        let conversationRow = messagesList[indexPath.row]
        
        if let uid: String = conversationRow.conversationPartnerId() {
            let reference = FIRDatabase.database().reference().child("users").child(uid)
            reference.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String : Any] {
                    cell.userNameLabel.text = dictionary["username"] as? String
                    if let profileImageUrl: String = dictionary["profileImageUrl"] as! String? {
                        cell.userImagePhoto.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
                    }
                }
            }, withCancel: nil)
        }
        cell.shortMessageLabel.text = conversationRow.text
        if let seconds = Double(conversationRow.time!) {
            let sentTimeDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.sentTimeLabel.text = dateFormatter.string(from: sentTimeDate as Date)
        }
        return cell
    }
    
    func collectionView(_ sizeForItemAtcollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = view.frame.width
        return CGSize(width: frameWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let conversation = messagesList[indexPath.row]
        let userUid: String?
        if conversation.fromUid == FIRAuth.auth()?.currentUser?.uid {
            userUid = conversation.toUid
        } else {
            userUid = conversation.fromUid
        }
        let reference = FIRDatabase.database().reference().child("users").child(userUid!)
        reference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else {
                return
            }
            let user = User()
            user.uid = userUid
            user.setValuesForKeys(dictionary)
            self.showConversationLogForSelectedUser(user: user)
            /*let logOutController = LogOutLauncher()
             logOutController.logOutLaunch()*/
            //self.window?.rootViewController?.present(WelcomeViewController(), animated: true, completion: nil)
        }, withCancel: nil)
    }
    
    func checkIsUserLogIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(logoutProfile), with: nil, waitUntilDone: false)
        } else {
            loadUser()
        }
    }
    
    func loadUser() {
        print("Load Users")
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                user.setValuesForKeys(dictionary)
                self.setupUser(user: user)
            }
            
        }, withCancel: nil)
    }
    
    func setupUser(user: User) {
        messagesList.removeAll()
        conversationDictionary.removeAll()
        self.collectionView?.reloadData()
        listeningUserMessages()
    }
    
    func listeningUserMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let reference = FIRDatabase.database().reference().child("userMessages").child(uid)
        reference.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageReference = FIRDatabase.database().reference().child("messages").child(messageId)
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    let message = MessageWrapper(dictionary: dictionary)
                    message.setValuesForKeys(dictionary)
                    
                    if let partnerUid = message.conversationPartnerId() {
                        self.conversationDictionary[partnerUid] = message
                        self.messagesList = Array(self.conversationDictionary.values)
                        self.messagesList.sort(by: { (m1, m2) -> Bool in
                            return Int(m1.time!)! > Int(m2.time!)!
                        })
                    }
                    
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.collectionView?.reloadData), userInfo: nil, repeats: false)
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    func logoutProfile() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        present(WelcomeViewController(), animated: true, completion: nil)
    }
    
    func showConversationLogForSelectedUser(user: User) {
        let conversationLogViewController = ConversationLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        conversationLogViewController.user = user
        present(MainNavigationController(rootViewController: conversationLogViewController), animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    var timer: Timer?
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

}
