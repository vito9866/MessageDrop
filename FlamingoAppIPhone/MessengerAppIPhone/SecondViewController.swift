//
//  SecondViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = self.editButtonItem;
        //navigationController?.navigationBar.barTintColor = UIColor(red: 238.0/255.0, green: 219.0/255.0, blue: 242.0/255.0, alpha: 0.7/1.0)
        //navigationController?.navigationBar.barTintColor = UIColor(red: 235.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 0.7/1.0)
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 160.0/255.0, green: 43.0/255.0, blue: 184.0/255.0, alpha: 1.0/1.0)]
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)]
        //tableView.separatorColor = UIColor(red: 215.0/255.0, green: 174.0/255.0, blue: 224.0/255.0, alpha: 0.4/1.0)
        tableView.separatorColor = UIColor(red: 163.0/255.0, green: 206.0/255.0, blue: 239.0/255.0, alpha: 0.4/1.0)
        
        
        //self.navigationBar.shadowImage = UIImage(named: "")
        //navigationController?.navigationBar.shadowImage = UIImage(named: "")
        //defaultColorNavigationBar = UINavigationBar.appearance().tintColor
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 0.9/1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    
    //var users: [String] = ["User1", "User2", "User3"]
    var users: [InfoCardPeopleTableViewController] = [
        InfoCardPeopleTableViewController(peoplePhotoImage: "RichardHendricks_photo", peopleName: "Richard Hendricks", peopleMessageText: "Take the new beta version Pied…", sentTime: "9:07"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "DineshNanjiani_photo", peopleName: "Dinesh Nanjiani", peopleMessageText: "Please, donate $500 for my…", sentTime: "8:49"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "GilfoyleStarr_photo", peopleName: "Gilfoyle Starr", peopleMessageText: "I am checking our new server.", sentTime: "8:00"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "JaredWoods_photo", peopleName: "Jared Woods", peopleMessageText: "We will work by new skram.", sentTime: "Yesterday"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "ErlichBachman_photo", peopleName: "Erlich Bachman", peopleMessageText: "Photo", sentTime: "Yesterday"),
        InfoCardPeopleTableViewController(peoplePhotoImage: "RussHanneman_photo", peopleName: "Russ Hanneman", peopleMessageText: "OK, dude!", sentTime: "Yesterday"),
        
    ]
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PeopleTableViewCell
        cell.peopleNameLabel.text = users[indexPath.row].peopleName
        //cell.peopleNameLabel.textColor = UIColor(red: 160.0/255.0, green: 43.0/255.0, blue: 184.0/255.0, alpha: 1.0/1.0)
        cell.peopleNameLabel.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.peoplePhotoImage.image = UIImage(named: users[indexPath.row].peoplePhotoImage)
        cell.peoplePhotoImage.layer.cornerRadius = 30.0
        cell.peoplePhotoImage.clipsToBounds = true
        cell.textMessageLabel.text = users[indexPath.row].peopleMessageText
        //cell.textMessageLabel.textColor = UIColor(red: 176.0/255.0, green: 141.0/255.0, blue: 184.0/255.0, alpha: 1.0/1.0)
        cell.textMessageLabel.textColor = UIColor(red: 164.0/255.0, green: 173.0/255.0, blue: 203.0/255.0, alpha: 1.0/1.0)
        cell.peopleNameLabel.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.sentTimeLabel.text = users[indexPath.row].sentTime
        //cell.sentTimeLabel.textColor = UIColor(red: 180.0/255.0, green: 188.0/255.0, blue: 211.0/255.0, alpha: 1.0/1.0)
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
                conversationController.userName = users[indexPath.item].peopleName
            }
        }
    }
    
    @IBAction func unwindToSecondViewController(segue: UIStoryboard) {
    }
    
    
    
    
}
