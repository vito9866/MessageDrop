//
//  ConversationTableViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 23/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ContactsListTableViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 0.3/1.0)
        self.navigationItem.title = "Contacts";
        //self.navigationController!.navigationBar.tintColor = UIColor(red: 72.0/255.0, green: 83.0/255.0, blue: 125.0/255.0, alpha: 1.0/1.0)
        //self.navigationController!.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor(red: 72.0/255.0, green: 83.0/255.0, blue: 125.0/255.0, alpha: 1.0/1.0)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        loadUsers()
    }

    var users = [User]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Count of users \(users.count)")
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ContactsTableViewCell
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.peopleNameLabel.text = users[indexPath.row].username
        print(users[indexPath.row].username)
        cell.peopleNameLabel.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        
        cell.peoplePhotoImage.image = UIImage(named: "EmptyAvatarList")
        cell.peoplePhotoImage.layer.cornerRadius = 25.0
        cell.peoplePhotoImage.clipsToBounds = true
        
        if let profileImageUrl: String = users[indexPath.row].profileImageUrl {
            cell.peoplePhotoImage.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
        }
        
        cell.peopleEmailLabel.text = users[indexPath.row].email
        cell.peopleEmailLabel.textColor = UIColor(red: 185.0/255.0, green: 190.0/255.0, blue: 198.0/255.0, alpha: 1.0/1.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.showConversationLogForSelecteddUser(user: user)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func loadUsers() {
        print("Starting load users")
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User()
                user.uid = snapshot.key
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                print("Success load user")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            print("User found")
            print(snapshot)
            }, withCancel: nil)
    }
    
    @IBAction func unwindToSecondViewController(segue: UIStoryboard) {
    }
    
    func showConversationLogForSelecteddUser(user: User) {
        let conversationLogViewController = ConversationLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        conversationLogViewController.user = user
        navigationController?.pushViewController(conversationLogViewController, animated: true)
    }
}
