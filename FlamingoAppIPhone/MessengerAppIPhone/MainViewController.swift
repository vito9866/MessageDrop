//
//  MainViewController.swift
//  MessengerAppIPhone
//
//  Created by Victor Macintosh on 15/11/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        self.navigationController?.navigationBar.barStyle = .black;
        return .lightContent
    }
    
    var views = [UIView]()
    let topMenuBarItems = ["Chats", "Search", "Profile"]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.view.bounds.height)), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.white
        cv.backgroundColor = UIColor.clear
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.isDirectionalLockEnabled = true
        return cv
    }()
    
    lazy var topMenuBar: TopMenuBar = {
        let menuBar = TopMenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.mainViewController = self
        return menuBar
    }()
    
    func customization()  {
        
        let tempView = UIView()
        tempView.backgroundColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
        view.addSubview(tempView)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tempView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tempView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        
        //CollectionView Customization
        self.collectionView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        
        //TabBar
        
        /*let topLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()*/

        
        self.view.addSubview(self.topMenuBar)
        topMenuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topMenuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topMenuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //topMenuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        topMenuBar.topAnchor.constraint(equalTo: view.topAnchor  ).isActive = true
        //topMenuBar.layoutIfNeeded()
        //topMenuBar.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 20).isActive = true
        
        //NavigationBar
        self.navigationController?.navigationItem.title = "Flamingo"
        
        //ViewControllers init
        for title in self.topMenuBarItems {
            //let storyBoard = self.storyboard!
            //let vc = storyBoard.instantiateViewController(withIdentifier: title)
            let layout = UICollectionViewFlowLayout()
            if title == "Chats" {
                let vc = ChatsViewController(collectionViewLayout: layout)
                self.addChildViewController(vc)
                vc.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
                vc.didMove(toParentViewController: self)
                self.views.append(vc.view)
            } else if (title == "Search") {
                let vc = ContactsViewController(collectionViewLayout: layout)
                self.addChildViewController(vc)
                vc.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 48))
                vc.didMove(toParentViewController: self)
                self.views.append(vc.view)
            } else if (title == "Profile") {
                let vc = ProfileViewController()
                self.addChildViewController(vc)
                vc.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 108))
                vc.didMove(toParentViewController: self)
                self.views.append(vc.view)

            }
            
        }
        //self.viewsAreInitialized = true
    }
    
    func didSelectItem(atIndex: Int) {
        self.collectionView.scrollRectToVisible(CGRect.init(origin: CGPoint.init(x: (self.view.bounds.width * CGFloat(atIndex)), y: 0), size: self.view.bounds.size), animated: true)
    }
    
    func hideBar(notification: NSNotification)  {
        let state = notification.object as! Bool
        self.navigationController?.setNavigationBarHidden(state, animated: true)
    }
    
    override func viewDidLoad() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        self.navigationItem.title = "Flamingo"
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        customization()
        didSelectItem(atIndex: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.hideBar(notification:)), name: NSNotification.Name("hide"), object: nil)
    }
    
    func topMenuBarItems(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.contentView.addSubview(self.views[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.bounds.width, height: (self.view.bounds.height))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topMenuBar.selectedBarLeftAnchor?.constant = scrollView.contentOffset.x / 3 + 10
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = NSIndexPath(item: Int(CGFloat(targetContentOffset.pointee.x / view.frame.width)), section: 0)
        topMenuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
    }
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

