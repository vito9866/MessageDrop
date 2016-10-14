//
//  ConversationListTableViewController.swift
//  MessengerFinal
//
//  Created by Роман Чепкий on 12.10.16.
//  Copyright © 2016 Роман Чепкий. All rights reserved.
//

import UIKit

class ConversationListTableViewController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor(red: 163.0/255.0, green: 206.0/255.0, blue: 239.0/255.0, alpha: 0.4/1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 235.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 0.7/1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)]
    }
    var users: [infoCardPeopleTableViewController] = [
        infoCardPeopleTableViewController(peoplePhotoImage: "RichardHendricks_photo", peopleName: "Richard Hendricks", peopleMessageText: "Take the new beta version Pied…", sentTime: "9:07"),
        infoCardPeopleTableViewController(peoplePhotoImage: "DineshNanjiani_photo", peopleName: "Dinesh Nanjiani", peopleMessageText: "Please, donate $500 for my…", sentTime: "8:49"),
        infoCardPeopleTableViewController(peoplePhotoImage: "GilfoyleStarr_photo", peopleName: "Gilfoyle Starr", peopleMessageText: "I am checking our new server.", sentTime: "8:00"),
        infoCardPeopleTableViewController(peoplePhotoImage: "JaredWoods_photo", peopleName: "Jared Woods", peopleMessageText: "We will work by new skram.", sentTime: "Yesterday"),
        infoCardPeopleTableViewController(peoplePhotoImage: "ErlichBachman_photo", peopleName: "Erlich Bachman", peopleMessageText: "Photo", sentTime: "Yesterday"),
        infoCardPeopleTableViewController(peoplePhotoImage: "RussHanneman_photo", peopleName: "Russ Hanneman", peopleMessageText: "OK, dude!", sentTime: "Yesterday"),
        
        ]
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentificator = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewControllerCell
        cell.name.text = users[indexPath.item].peopleName
        cell.name.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.message.text = users[indexPath.item].peopleMessageText
        cell.message.textColor = UIColor(red: 76.0/255.0, green: 95.0/255.0, blue: 151.0/255.0, alpha: 1.0/1.0)
        cell.time.text = users[indexPath.item].sentTime
        cell.time.textColor = UIColor(red: 180.0/255.0, green: 188.0/255.0, blue: 211.0/255.0, alpha: 1.0/1.0)
        
        cell.peoplePhotoImage.image = UIImage(named: users[indexPath.item].peoplePhotoImage)
        cell.peoplePhotoImage.layer.cornerRadius = 30
        cell.peoplePhotoImage.clipsToBounds = true
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
