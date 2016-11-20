//
//  ContactsViewController.swift
//  MessengerAppIPhone
//
//  Created by Victor Macintosh on 15/11/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var myText = ""
    
    //Properties
    let cellId = "CellId"
    var users = [User]()
    var bufferUsers = [User]()
    var lastContentOffset: CGFloat = 0.0
    
    //Methods
    func loadUsers() {
        print("Starting load users")
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User()
                user.uid = snapshot.key
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                self.bufferUsers.append(user)
                print("Success load user")
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            print("User found")
            print(snapshot)
        }, withCancel: nil)
    }
    
    let searchField: SearchCollectionViewCell = {
        let search = SearchCollectionViewCell()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.isUserInteractionEnabled = true
        //search.searchBar.resignFirstResponder()
        return search
    }()
    
    func customization() {
        self.collectionView?.contentInset = UIEdgeInsetsMake(65, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        self.collectionView?.backgroundColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0/1.0)
        self.collectionView?.register(ContactsListCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        //self.collectionView?.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "searchCell")

        view.addSubview(searchField)
        searchField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchField.searchBar.delegate = self
        searchField.searchBar.addTarget(self, action: #selector(ContactsViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        //searchField.searchBar.resignFirstResponder()
        //searchField.searchBar.becomeFirstResponder()
    }
    
    func showConversationLogForSelectedUser(user: User) {
        let conversationLogViewController = ConversationLogCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        conversationLogViewController.user = user
        present(MainNavigationController(rootViewController: conversationLogViewController), animated: true, completion: nil)
    }
    
    //ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customization()
        loadUsers()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactsListCollectionViewCell
        cell.userNameLabel.text = users[indexPath.row].username
        cell.userEmailLabel.text = users[indexPath.row].email
        if let profileImageUrl: String = users[indexPath.row].profileImageUrl {
            cell.userImagePhoto.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.showConversationLogForSelectedUser(user: user)
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    //TextFieldParse
    func textFieldDidChange(_ textField: UITextField) {
        myText = textField.text!
        print("MyText = \(myText)")
        if (self.myText == "") {
            self.users = self.bufferUsers
            print("Count = \(self.users.count)")
            print("Reload to default")
            self.collectionView?.reloadData()
        } else {
            print("Search")
            self.users.removeAll()
            FIRDatabase.database().reference().child("users").observe(.childAdded, with:{ (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    let user = User()
                    user.uid = snapshot.key
                    user.setValuesForKeys(dictionary)
                    if user.username == self.myText {
                        self.users.append(user)
                        print("Search Count = \(self.users.count)")
                        print("Search Success load user")
                        //self.collectionView?.reloadData()
                        print("Username = \(self.users[0].email)")
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                       // OperationQueue.main.addOperation((self.collectionView?.reloadData)!)
                    }
                }
            }, withCancel: nil)
        }
    }
}
