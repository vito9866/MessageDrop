//
//  SecondViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UITableViewController {

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
        
        self.checkIsUserLogIn()
        
        tableView.separatorColor = UIColor(red: 200.0/255.0, green: 205.0/255.0, blue: 223.0/255.0, alpha: 0.4/1.0)
        self.navigationItem.title = "Conversations";
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    /*var users: [InfoCardPeopleTableViewController] = [
        InfoCardPeopleTableViewController(peoplePhotoImage: "RichardHendricks_photo", peopleName: "Richard Hendricks", peopleMessageText: "Take the new beta version Pied…", sentTime: "9:07"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "DineshNanjiani_photo", peopleName: "Dinesh Nanjiani", peopleMessageText: "Please, donate $500 for my…", sentTime: "8:49"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "GilfoyleStarr_photo", peopleName: "Gilfoyle Starr", peopleMessageText: "I am checking our new server.", sentTime: "8:00"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "JaredWoods_photo", peopleName: "Jared Woods", peopleMessageText: "We will work by new skram.", sentTime: "Yesterday"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "ErlichBachman_photo", peopleName: "Erlich Bachman", peopleMessageText: "Photo", sentTime: "Yesterday"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "RussHanneman_photo", peopleName: "Russ Hanneman", peopleMessageText: "OK, dude!", sentTime: "Yesterday"),
        
    ]*/
    
    //var users = [UserWrapper]()
    //var users = [InfoCardPeopleTableViewController]()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PeopleTableViewCell
        cell.peopleNameLabel.text = users[indexPath.row].username
        print(users[indexPath.row].username)
        cell.peopleNameLabel.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        
        cell.peoplePhotoImage.image = UIImage(named: "EmptyAvatarList")
        cell.peoplePhotoImage.layer.cornerRadius = 30.0
        cell.peoplePhotoImage.clipsToBounds = true
        
        if let profileImageUrl: String = users[indexPath.row].profileImageUrl {
            cell.peoplePhotoImage.loadImagesUsingCacheMemoryWithUrlString(urlString: profileImageUrl)
        }
        
        cell.textMessageLabel.text = "Take a new beta version"
        print("Take a new beta version")
        cell.textMessageLabel.textColor = UIColor(red: 164.0/255.0, green: 173.0/255.0, blue: 203.0/255.0, alpha: 1.0/1.0)
        cell.peopleNameLabel.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.sentTimeLabel.text = "00:00"
        print("00:00")
        cell.sentTimeLabel.textColor = UIColor(red: 180.0/255.0, green: 188.0/255.0, blue: 211.0/255.0, alpha: 1.0/1.0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConversation" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let conversationController = segue.destination as! ConversationCollectionViewController
                conversationController.userName = users[indexPath.item].username!
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    func loadUsers() {
        print("Starting load users")
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let user = User()
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
    
    func checkIsUserLogIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(logoutProfile), with: nil, waitUntilDone: false)
        } else {
            print("Success checking login")
            self.loadUsers()
        }
    }
    
    @IBAction func logoutProfile() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! ViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func unwindToSecondViewController(segue: UIStoryboard) {
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImagesUsingCacheMemoryWithUrlString(urlString: String) {
        /*if let profileImageUrl: String = users[indexPath.row].profileImageUrl {
         let url = NSURL(string: profileImageUrl)
         URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
         if error != nil {
         print("Error load user photo from the server")
         return
         }
         DispatchQueue.main.async {
         print("Success load user photo from the server")
         cell.peoplePhotoImage.image = UIImage(data: data!)
         }
         }).resume()
         }*/
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
