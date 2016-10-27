//
//  SecondViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ActiveConversationsTableViewController: UITableViewController, UICollectionViewDelegateFlowLayout {
    
    var messagesList = [MessageWrapper]()
    var conversationDictionary = [String : MessageWrapper]()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.logoutProfile()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.separatorColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 0.3/1.0)
        self.navigationItem.title = "Conversations";
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        
        self.checkIsUserLogIn()
        
        //self.setupBottomNavigationConstraints()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Messages count: \(messagesList.count)")
        return messagesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PeopleTableViewCell
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        //cell.peopleNameLabel.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.peopleNameLabel.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        cell.peoplePhotoImage.layer.cornerRadius = 25.0
        cell.peoplePhotoImage.clipsToBounds = true
        //cell.textMessageLabel.textColor = UIColor(red: 164.0/255.0, green: 173.0/255.0, blue: 203.0/255.0, alpha: 1.0/1.0)
        cell.textMessageLabel.textColor = UIColor(red: 185.0/255.0, green: 190.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0)
        //cell.sentTimeLabel.textColor = UIColor(red: 180.0/255.0, green: 188.0/255.0, blue: 211.0/255.0, alpha: 1.0/1.0)
        cell.sentTimeLabel.textColor = UIColor(red: 185.0/255.0, green: 190.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0)
        let conversationRow = messagesList[indexPath.row]
        
        if let uid: String = conversationRow.conversationPartnerId() {
            let reference = FIRDatabase.database().reference().child("users").child(uid)
            reference.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String : Any] {
                    cell.peopleNameLabel.text = dictionary["username"] as? String
                    if let profileImageUrl: String = dictionary["profileImageUrl"] as! String? {
                        cell.peoplePhotoImage.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
                    }
                }
                }, withCancel: nil)
        }
        
        cell.textMessageLabel.text = conversationRow.text
        if let seconds = Double(conversationRow.time! as String) {
            let sentTimeDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            cell.sentTimeLabel.text = dateFormatter.string(from: sentTimeDate as Date)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            self.showConversationLogForSelecteddUser(user: user)
            }, withCancel: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func checkIsUserLogIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(logoutProfile), with: nil, waitUntilDone: false)
        } else {
            loadUser()
        }
    }
    
    func loadUser() {
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
        tableView.reloadData()
        listeningUserMessages()
    }
    
    @IBAction func logoutProfile() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! SignInViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func unwindToSecondViewController(segue: UIStoryboard) {
    }
    
    func showConversationLogForSelecteddUser(user: User) {
        let conversationLogViewController = ConversationLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        conversationLogViewController.user = user
        navigationController?.pushViewController(conversationLogViewController, animated: true)
    }
    
    func listeningMessages() {
        let reference = FIRDatabase.database().reference().child("messages")
        reference.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let message = MessageWrapper()
                message.setValuesForKeys(dictionary)
                
                
                if let toUid = message.toUid {
                    self.conversationDictionary[toUid] = message
                    self.messagesList = Array(self.conversationDictionary.values)
                    self.messagesList.sort(by: { (m1, m2) -> Bool in
                        return Int(m1.time!)! > Int(m2.time!)!
                    })
                }
                
                print(message.text)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            }, withCancel: nil)
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
                    let message = MessageWrapper()
                    message.setValuesForKeys(dictionary)
                    
                    if let partnerUid = message.conversationPartnerId() {
                        self.conversationDictionary[partnerUid] = message
                        self.messagesList = Array(self.conversationDictionary.values)
                        self.messagesList.sort(by: { (m1, m2) -> Bool in
                            return Int(m1.time!)! > Int(m2.time!)!
                        })
                    }

                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadData), userInfo: nil, repeats: false)
                }
                }, withCancel: nil)
            }, withCancel: nil)
    }
    
    var timer: Timer?
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    /*func setupBottomNavigationConstraints() {
        //let containerView = UIView()
        //containerView.backgroundColor = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 1.0/1.0)
        /*containerView.backgroundColor = UIColor.red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        containerViewBottomAnchor?.isActive = true*/
        let bottomNavigationWrapper = UIView()
        self.tableView.addSubview(bottomNavigationWrapper)
        bottomNavigationWrapper.backgroundColor = UIColor.red
        bottomNavigationWrapper.leftAnchor.constraint(equalTo: self.tableView.leftAnchor).isActive = true
        bottomNavigationWrapper.rightAnchor.constraint(equalTo: self.tableView.rightAnchor).isActive = true
        bottomNavigationWrapper.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
        bottomNavigationWrapper.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }*/
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImagesUsingCacheMemoryWithUrlString(urlString: String) {
        if let cachedUserProfilePhoto = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedUserProfilePhoto
            return
        }
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            if error != nil {
                print("Error load user photo from the server")
                return
            }
            DispatchQueue.main.async {
                print("Success load user photo from the server")
                if let downloadedUserProfilePhoto = UIImage(data: data!) {
                    imageCache.setObject(downloadedUserProfilePhoto, forKey: urlString as AnyObject)
                    self.image = downloadedUserProfilePhoto
                }
            }
        }).resume()
    }
    
    
}
